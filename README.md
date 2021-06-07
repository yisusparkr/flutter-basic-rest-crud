# Basic REST - CRUD 📲🌐

A simple app to do REST services and CRUD. 

## Backend 💻

The backend was develop with PHP and phpMyAdmin, using 000webhost, the unique reason to realize the backend is to persist all the data of the users, when they sign in or sign up, and when they synchronize the interviews information.

## Database 💾

The database used in this project is Hive. This No-SQL db is potentially fast and easy to use, let us work with the data as boxes and in addition it encrypt the information.

## Screens 📱

### Sign in page
At this page you can sign in with account that already is registered in the backend, the app will notify if the account doesn't exists or if the password is wrong.

![image](https://user-images.githubusercontent.com/43246999/121052347-25898980-c76f-11eb-847f-f1f25c5870cd.png)

### Sign up page
You can create an account writing your name, email and password, the app will notify you if the email is already registered or if there was something wrong

![image](https://user-images.githubusercontent.com/43246999/121053081-d7c15100-c76f-11eb-901f-02850aa922b7.png)

### Home page
Here you will see your pending or completed interviews if you have added at least one, every interview is saved in the phone local memory, if you sign in with different accounts you will not see the same interviews because they're separated depending the user signed in.

![image](https://user-images.githubusercontent.com/43246999/121053965-c0369800-c770-11eb-9a90-36fd1b6a1957.png)


## Dialogs 🗨

### Add interview dialog
At this dialog you're initializing a new interview, if you don't add information and close the dialog, this interview will appear in the home page with empty information. You can't press the button save unless you have completed all the fields. But if you're thinking when you write information it is not saving, let me tell you that every key of the keyboard that you press will change that interview in the db and will save at the same time.

![image](https://user-images.githubusercontent.com/43246999/121054701-769a7d00-c771-11eb-9f7c-9e4458d89db0.png)

### Modify interview dialog
You can press every interview previously added, if this is not completed you can modify the information, but if this is completed you only can read the fields information.

![image](https://user-images.githubusercontent.com/43246999/121055144-db55d780-c771-11eb-8403-97810af0caa2.png)

## Sync interviews 🔄
At the Appbar you have an icon button, you can press it when you want to send all the completed interviews, when the synchronization is completed all the interviews sent will be deleted from yout phone.

![image](https://user-images.githubusercontent.com/43246999/121056016-a007d880-c772-11eb-9f0e-8c8b84617a6f.png)


