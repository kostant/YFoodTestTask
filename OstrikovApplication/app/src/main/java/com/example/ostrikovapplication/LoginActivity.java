package com.example.ostrikovapplication;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.widget.Button;
import android.widget.EditText;

import com.google.android.material.textfield.TextInputEditText;

public class LoginActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);

        EditText loginEditText = (EditText) findViewById(R.id.login);
        EditText passwwordEditText = (EditText) findViewById(R.id.password);
        Button loginButton = (Button) findViewById(R.id.logIn);
    }
}