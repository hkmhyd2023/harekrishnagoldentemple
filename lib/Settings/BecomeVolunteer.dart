import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class BAV extends StatefulWidget {
  const BAV({super.key});

  @override
  State<BAV> createState() => _BAVState();
}

class _BAVState extends State<BAV> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController = TextEditingController();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _messageController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: Text("Become a Voluenteer"), backgroundColor: Colors.white,),
      body: SingleChildScrollView(child: Column(children: [
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.network("https://www.iskconbangalore.org/wp-content/uploads/2015/11/a11-folk.jpg"),
                ),
                SizedBox(height: 10,),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.fromLTRB(10,2,10,2),
            decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(20),
               border: Border.all(color: Colors.orange)
            ),
            child: TextField(
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: "Full Name",
                
              ),
              controller: _nameController,
            ),
          ),
        ),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.fromLTRB(10,2,10,2),
            decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(20),
               border: Border.all(color: Colors.orange)
            ),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: "Email",
                
              ),
              controller: _emailController,
            ),
          ),
        ),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.fromLTRB(10,2,10,2),
            decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(20),
               border: Border.all(color: Colors.orange)
            ),
            child: TextField(
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: "Message",
                
                
              ),
              maxLength: 2000,
              maxLines: 7,
              controller: _messageController,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            height: 45,
            width: double.infinity,
            child: ElevatedButton(
              
              style: ButtonStyle(
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.0),
    )
  ),

  backgroundColor: MaterialStateProperty.all<Color>(Colors.orange)
),
          
            onPressed: () async {
                // Get form data
                final name = _nameController.text;
                final email = _emailController.text;
                final text_message = _messageController.text;
          
                // Create SMTP server configuration
                final smtpServer = gmail('hkm.hyd2023', 'pbnknhahipdgbpbr');
          
                // Create email message
                final message = Message()
            ..from = Address(email, name)
            ..recipients.add('hkm.hyd2023@gmail.com') // Replace with your recipient email address
            ..subject = 'Message from $name for knowing about voluenteering via the app'
            ..html = '''
            <h3>New message from $name</h3>
            <p><strong>Name:</strong> $name</p>
            <p><strong>Email:</strong> $email</p>
            <p><strong>Message:</strong> $text_message</p>
            ''';
          
                // Send email
                try {
            final sendReport = await send(message, smtpServer);
            print('Message sent: ${sendReport.toString()}');
            const snackBar = SnackBar(
            content: Text('Message Successfuly Sent Will Reach You Soon On Your Eentered Your Email ID'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          
                } on MailerException catch (e) {
            print('Message not sent: ${e.toString()}');
                }
              },
              child: Text("Submit", style: TextStyle(color: Colors.white),),
            ),
          ),
        ),

      ],)),
    );
  }
}