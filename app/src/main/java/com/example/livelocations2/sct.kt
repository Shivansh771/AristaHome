package com.example.livelocations2

import android.content.Context
import android.content.Intent
import android.content.pm.ShortcutInfo
import android.content.pm.ShortcutManager
import android.graphics.drawable.Icon
import android.net.Uri
import android.os.Build
import androidx.annotation.RequiresApi
import androidx.core.content.ContextCompat.getSystemService

const val shortcut_website_id="id_website"
@RequiresApi(Build.VERSION_CODES.N_MR1)
object sct {

    fun setUp(context: Context){
        val shorcutManager= getSystemService<ShortcutManager>(context, ShortcutManager::class.java)
        val intents= arrayOf(Intent(Intent.ACTION_VIEW,null,context,MainActivity::class.java))
        val shortcut=ShortcutInfo.Builder(context, shortcut_website_id).setShortLabel("Button").setLongLabel("Open the website").setIcon(
            Icon.createWithResource(context,R.drawable.ic_baseline_edgesensor_high_24)).setIntents(
            intents
        ).build()
        shorcutManager!!.dynamicShortcuts=listOf(shortcut)
    }

}
