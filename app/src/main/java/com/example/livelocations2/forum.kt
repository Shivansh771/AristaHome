package com.example.livelocations2

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView

class forum : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_forum)

        // getting the recyclerview by its id
        val recyclerview = findViewById<RecyclerView>(R.id.recyclerview)

        // this creates a vertical layout Manager
        recyclerview.layoutManager = LinearLayoutManager(this)

        // ArrayList of class ItemsViewModel
        val data = ArrayList<ItemsViewModel>()
        data.add(ItemsViewModel(R.drawable.helpline,"How often do women helpline numbers actually respond? "))
        // This loop will create 20 Views containing
        // the image with the count of view
        data.add(ItemsViewModel(R.drawable.def,"Self Defense 101"))
        data.add(ItemsViewModel(R.drawable.mumbai,"Hotel recommendations in Mumbai!"))
        data.add(ItemsViewModel(R.drawable.essen,"Things that are important that need to be carried"))
        data.add(ItemsViewModel(R.drawable.img_3,"What is something you wish you could tell every young woman about staying safe"))
        data.add(ItemsViewModel(R.drawable.img_4,"Therapy for you by you!"))
        data.add(ItemsViewModel(R.drawable.def,"Self Defense 101"))
        data.add(ItemsViewModel(R.drawable.mumbai,"Hotel recommendations in Mumbai!"))
        data.add(ItemsViewModel(R.drawable.essen,"Things that are important that need to be carried"))
        data.add(ItemsViewModel(R.drawable.img_3,"What is something you wish you could tell every young woman about staying safe"))
        data.add(ItemsViewModel(R.drawable.img_4,"Therapy for you by you!"))
        data.add(ItemsViewModel(R.drawable.def,"Self Defense 101"))
        data.add(ItemsViewModel(R.drawable.mumbai,"Hotel recommendations in Mumbai!"))
        data.add(ItemsViewModel(R.drawable.essen,"Things that are important that need to be carried"))
        data.add(ItemsViewModel(R.drawable.img_3,"What is something you wish you could tell every young woman about staying safe"))
        data.add(ItemsViewModel(R.drawable.img_4,"Therapy for you by you!"))


        // This will pass the ArrayList to our Adapter
        val adapter = CustomAdapter(data)

        // Setting the Adapter with the recyclerview
        recyclerview.adapter = adapter

    }
}