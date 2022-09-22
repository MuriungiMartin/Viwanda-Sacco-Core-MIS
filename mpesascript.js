function createIframe()
{
    var placeholder=document.getElementById('controlAddIn');
    var webPage= document.createElement('iframe');
    webPage.id='webPage';
    webPage.height='100%';
    webPage.width='100%';
    placeholder.appendChild(webPage);
}

function pay() {

    createIframe();
 //   phoneNo='0704536696';
   //var webPage=document.getElementById('webPage');
    // webPage.src = 'C:/Users/muriu/OneDrive/Pictures/index.html';
    //webPage.src = 'https://outlook.com/';
alert("About to pay  ${phoneNo}");
    var url = "https://tinypesa.com/api/v1/express/initialize";

    fetch(url, {
        body: "amount=1&msisdn=0743915198&account_no=1237663725",
        headers: {
            Apikey: "hqsWRTiWsdk",
            "Content-Type": "application/x-www-form-urlencoded",
        },
        method: "POST",
    });

}