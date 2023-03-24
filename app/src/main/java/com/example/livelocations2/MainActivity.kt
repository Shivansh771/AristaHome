package com.example.livelocations2
import android.Manifest
import android.annotation.SuppressLint
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.Color
import android.hardware.camera2.CameraManager
import android.location.Address
import android.location.Geocoder
import android.location.Location
import android.location.LocationManager
import android.media.AudioManager
import android.media.MediaPlayer
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.provider.MediaStore.Audio.Media
import android.provider.Settings
import android.telephony.SmsManager
import android.util.Log
import android.widget.Toast
import androidx.annotation.RequiresApi
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.ActivityCompat
import com.example.livelocations2.databinding.ActivityMainBinding
import com.example.livelocations2.sct.setUp
import com.google.android.gms.location.FusedLocationProviderClient
import com.google.android.gms.location.LocationServices
import java.io.IOException
import java.util.*
import java.util.logging.Logger.global

class MainActivity : AppCompatActivity() {
    private lateinit var mainBinding: ActivityMainBinding
    private lateinit var mFusedLocationClient: FusedLocationProviderClient
    private val permissionId = 2
    var mediaPlayer:MediaPlayer?=null
    private var player:MediaPlayer?=null
    @RequiresApi(Build.VERSION_CODES.LOLLIPOP_MR1)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        mainBinding = ActivityMainBinding.inflate(layoutInflater)

        if(Build.VERSION.SDK_INT>=25){
            sct.setUp(applicationContext)
        }
        setContentView(mainBinding.root)
        mFusedLocationClient = LocationServices.getFusedLocationProviderClient(this)

        mainBinding.btnLocation.setOnClickListener {
            var number:String?=mainBinding?.editTextPhone?.toString()
            getLocation()
            sendSMS()

        }
        var cm=getSystemService(Context.CAMERA_SERVICE) as CameraManager

        mainBinding.flash.setOnClickListener{
            if(packageManager.hasSystemFeature(PackageManager.FEATURE_CAMERA_FLASH)){
                var light=false
                var s="1011010101010101010101000111001101010"
                for(i in s.indices){

                        light= s[i]=='1'

                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                                cm.setTorchMode(cm.cameraIdList[0],light)
                            }
                            Thread.sleep(50)

                    }

                }
            }
        mainBinding.panic.setOnClickListener{
            try{
                val soundUri=Uri.parse("android.resource://com.example.livelocations2/"+R.raw.app_src_main_res_raw_press_start)
                player=MediaPlayer.create(applicationContext,soundUri)
                player?.isLooping=false
                player?.start()
            }catch(e:Exception){
                e.printStackTrace()
            }
        }

        mainBinding.forum.setOnClickListener{
            val intent=Intent(this,forum::class.java)
            startActivity(intent)
        }
        mainBinding.pin.setOnClickListener{
            val intent=Intent(this,HeatMap::class.java)
            startActivity(intent)
        }
        mainBinding.threedots.setOnClickListener{

            val intent=Intent(this,com.example.livelocations2.Settings::class.java)
            startActivity(intent)
        }
        mainBinding.features.setOnClickListener{
            val intent=Intent(this,Features::class.java)
            startActivity(intent)
        }

        }


    @RequiresApi(Build.VERSION_CODES.LOLLIPOP_MR1)
    @SuppressLint("MissingPermission", "SetTextI18n")
    private fun getLocation(){
        if (checkPermissions()) {
            if (isLocationEnabled()) {
                mFusedLocationClient.lastLocation.addOnCompleteListener(this) { task ->
                    val location: Location? = task.result
                    if (location != null) {
                        val geocoder = Geocoder(this, Locale.getDefault())
                        val list: List<Address> = geocoder.getFromLocation(location.latitude, location.longitude, 1) as List<Address>
                        mainBinding.apply {
                            tvLatitude.text = "Latitude\n${list[0].latitude}"
                            tvLongitude.text = "Longitude\n${list[0].longitude}"
                            tvCountryName.text = "Country Name\n${list[0].countryName}"
                            tvLocality.text = "Locality\n${list[0].locality}"
                            tvAddress.text = "Address\n${list[0].getAddressLine(0)}"
                        }
                    }
                }



            } else {
                Toast.makeText(this, "Please turn on location", Toast.LENGTH_LONG).show()
                val intent = Intent(Settings.ACTION_LOCATION_SOURCE_SETTINGS)
                startActivity(intent)
            }
        } else {
            requestPermissions()
        }
    }
    private fun sendSMS(){
        var sms=SmsManager.getDefault()
        var mail="An SOS alert was triggered by the user at the location; ${mainBinding?.tvLatitude?.text.toString()}  ${mainBinding?.tvLongitude?.text.toString()} "
        val mail2="${mainBinding?.tvAddress?.text.toString()}"
        var number:String=mainBinding.editTextPhone.text.toString()

        sms.sendTextMessage(number,null,mail,null,null)
        sms.sendTextMessage(number,null,mail2,null,null)
    }
    private fun isLocationEnabled(): Boolean {
        val locationManager: LocationManager =
            getSystemService(LOCATION_SERVICE) as LocationManager
        return locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER) || locationManager.isProviderEnabled(
            LocationManager.NETWORK_PROVIDER
        )
    }
    private fun checkPermissions(): Boolean {
        if (ActivityCompat.checkSelfPermission(
                this,
                Manifest.permission.ACCESS_COARSE_LOCATION
            ) == PackageManager.PERMISSION_GRANTED &&
            ActivityCompat.checkSelfPermission(
                this,
                Manifest.permission.ACCESS_FINE_LOCATION
            ) == PackageManager.PERMISSION_GRANTED
        ) {
            return true
        }
        return false
    }
    private fun requestPermissions() {
        ActivityCompat.requestPermissions(
            this,
            arrayOf(Manifest.permission.CAMERA,Manifest.permission.RECEIVE_SMS,Manifest.permission.SEND_SMS,
                Manifest.permission.ACCESS_COARSE_LOCATION,
                Manifest.permission.ACCESS_FINE_LOCATION
            ),
            permissionId
        )
    }
    @RequiresApi(Build.VERSION_CODES.LOLLIPOP_MR1)
    @SuppressLint("MissingSuperCall")
    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<String>,
        grantResults: IntArray
    ) {
        if (requestCode == permissionId) {
            if ((grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED)) {
                getLocation()
            }
        }
    }
}