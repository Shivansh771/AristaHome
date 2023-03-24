package com.example.livelocations2

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import com.example.livelocations2.databinding.ActivityMainBinding
import com.example.livelocations2.databinding.ActivityUserProfileBinding

class UserProfile : AppCompatActivity() {
    private var binding:ActivityUserProfileBinding?=null
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding= ActivityUserProfileBinding.inflate(layoutInflater)
        setContentView(binding!!.root)
        setSupportActionBar(binding?.toolbarUserprofileActivity)
        if(supportActionBar!=null){
            supportActionBar?.setDisplayHomeAsUpEnabled(true)
            supportActionBar?.title=" "
        }
        binding?.toolbarUserprofileActivity?.setNavigationOnClickListener{
            onBackPressed()
        }
        binding?.back?.setOnClickListener{
            onBackPressed()

        }
    }
}