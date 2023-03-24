package com.example.livelocations2

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import com.example.livelocations2.databinding.ActivitySettingsBinding

class Settings : AppCompatActivity() {
    var binding:ActivitySettingsBinding?=null
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding=ActivitySettingsBinding.inflate(layoutInflater)

        setContentView(binding!!.root)
        binding!!.goback.setOnClickListener{
            onBackPressed()
        }
        
    }
}