package com.example.livelocations2

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import com.example.livelocations2.databinding.ActivityHeatMapBinding

class HeatMap : AppCompatActivity() {
    var binding:ActivityHeatMapBinding?=null
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding=ActivityHeatMapBinding.inflate(layoutInflater)
        setContentView(binding!!.root)
        if(supportActionBar!=null){
            supportActionBar?.setDisplayHomeAsUpEnabled(true)
            supportActionBar?.title="HeatMap"
        }
        binding?.toolbarBmiActivity?.setNavigationOnClickListener{
            onBackPressed()
        }
        binding?.home?.setOnClickListener{
            val intent=Intent(this,MainActivity::class.java)
            startActivity(intent)
            finish()
        }
        binding?.forum?.setOnClickListener{
            val intent=Intent(this,forum::class.java)
            startActivity(intent)
            finish()
        }
        binding?.features?.setOnClickListener{
            val intent=Intent(this,Features::class.java)
            startActivity(intent)
            finish()
        }
    }
}