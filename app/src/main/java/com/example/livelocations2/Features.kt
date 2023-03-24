package com.example.livelocations2

import android.app.Dialog
import android.content.Intent
import android.graphics.Color
import android.graphics.drawable.ColorDrawable
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import com.example.livelocations2.databinding.ActivityFeaturesBinding

class Features : AppCompatActivity() {
    var binding:ActivityFeaturesBinding?=null
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding=ActivityFeaturesBinding.inflate(layoutInflater)
        setContentView(binding!!.root)
        binding?.power?.setOnClickListener{
            val dialogBinding =layoutInflater.inflate(R.layout.my_custom_dialog,null)
            val myDialog=Dialog(this)
            myDialog.setContentView(dialogBinding)

            myDialog.setCanceledOnTouchOutside(true)
            myDialog.window?.setBackgroundDrawable(ColorDrawable(Color.TRANSPARENT))

            myDialog.show()

        }
        binding?.gesturesbtn?.setOnClickListener{
            val dialogBinding =layoutInflater.inflate(R.layout.my_custom_dialog_gestures,null)
            val myDialog=Dialog(this)
            myDialog.setContentView(dialogBinding)

            myDialog.setCanceledOnTouchOutside(true)
            myDialog.window?.setBackgroundDrawable(ColorDrawable(Color.TRANSPARENT))

            myDialog.show()

        }
        binding?.home?.setOnClickListener{
            val intent= Intent(this,MainActivity::class.java)
            startActivity(intent)
            finish()
        }
        binding?.pin?.setOnClickListener{
            val intent=Intent(this,HeatMap::class.java)
            startActivity(intent)
            finish()
        }
        binding?.forum?.setOnClickListener{
            val intent=Intent(this,forum::class.java)
            startActivity(intent)
            finish()

        }
        binding?.voicebtn?.setOnClickListener{
            val dialogBinding =layoutInflater.inflate(R.layout.my_custom_dialog_voice,null)
            val myDialog=Dialog(this)
            myDialog.setContentView(dialogBinding)

            myDialog.setCanceledOnTouchOutside(true)
            myDialog.window?.setBackgroundDrawable(ColorDrawable(Color.TRANSPARENT))

            myDialog.show()
        }
        binding?.idhoome?.setOnClickListener{
            val intent=Intent(this,UserProfile::class.java)
            startActivity(intent)
            finish()
        }
        binding?.gesturesetup?.setOnClickListener{
            val dialogBinding =layoutInflater.inflate(R.layout.my_custom_dialog_setup,null)
            val myDialog=Dialog(this)
            myDialog.setContentView(dialogBinding)

            myDialog.setCanceledOnTouchOutside(true)
            myDialog.window?.setBackgroundDrawable(ColorDrawable(Color.TRANSPARENT))

            myDialog.show()
        }
    }
}