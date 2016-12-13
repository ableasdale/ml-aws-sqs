// 1. Configure AWS with credentials
AWS.config.update({accessKeyId: CONFIG.accessKeyId, secretAccessKey: CONFIG.secretAccessKey});
AWS.config.region = CONFIG.awsRegion;

// 2. Create and configure the SQS Object
var sqs = new AWS.SQS();
var queueUrl = CONFIG.awsQueueUrl;
var receiveMessageParams = { QueueUrl: queueUrl };


// Util functions below

function tryToGetMessage() {
  //console.log("checking messages..")
  // 3. Try to get some data
  sqs.receiveMessage(receiveMessageParams, receiveMessageCallback);
};

function receiveMessageCallback(err, data) {

  // console.log("try to parse");
 // var json = JSON.parse(data.Messages);
 // console.log("try to PROCESS");
 processRecordObj(data.Messages[0])
    /* Delete the message when we've successfully processed it
    var deleteMessageParams = {
      QueueUrl: queueUrl,
      ReceiptHandle: data.Messages[0].ReceiptHandle
    }; */
    // WE do not want to delete messages right now....
    // sqs.deleteMessage(deleteMessageParams, deleteMessageCallback);
};

function deleteMessageCallback(err, data) {
  //console.log("deleted message");
  //console.log(data);
}

function createTd(text){
  d = document.createElement('td'); //.createElement('textarea');
  $(d).html(text).appendTo( $(tr) );  
};

function createTdWithTextarea(text){
  d = document.createElement('td'); //.createElement('textarea');
  $(d).html("<textarea cols='120' rows='5'>" + text + "</textarea>").appendTo( $(tr) );
    
};

function processRecordObj(obj){
  //console.dir(obj);
  /* Build the table row */
  tr = document.createElement('tr');
  //createTd(obj.MD5OfBody);
  createTd(obj.MessageId);
  //createTd(obj.ReceiptHandle);
  //createTd(obj.Body.toString().substring(0,150));
  //JSON.stringify(obj.Body)
  createTdWithTextarea(obj.Body);
  
  //console.dir(tr.lastChild.lastChild);
  //hljs.highlightBlock(tr.lastChild.lastChild);
  
   
  $(tr).appendTo( $("tbody") ).hide();
  $(tr).fadeIn(400);
  CodeMirror.fromTextArea(tr.lastChild.lastChild);
  $(tr).delay(15000).fadeOut(1200);
    
};
