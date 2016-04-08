import std.stdio;
import std.variant;
import std.conv;

import xmlrpcc.client;

void main(string[] args) {
   string url = "http://phpxmlrpc.sourceforge.net/server.php";
   auto client = new Client(url);

   double resp1 = client.call!("examples.addtwodouble", double)(534.78, 168.36);
   writefln("add %s ", resp1);
   string resp2 = client.call!("examples.stringecho", string)("Hello Galaxy!");
   writefln("echo %s", resp2);

   real resp2_1 = client.call!("examples.stringecho", real)("123.456"); // IMPLICIT CONVERSION
   writefln("echo %f", resp2_1);

   int[string] resp3 = client.call!("validator1.countTheEntities", int[string])("A < C ' > 45\" 12 &");
   assert(1 == resp3["ctQuotes"]);
   assert(1 == resp3["ctLeftAngleBrackets"]);
   assert(1 == resp3["ctRightAngleBrackets"]);
   assert(1 == resp3["ctAmpersands"]);
   assert(1 == resp3["ctApostrophes"]);

   int[string][] arrayOfStructs = [["moe" : 1, "larry" : 2, "curly" : 3], ["moe" : -98, "larry" : 23, "curly" : -6]];
   int resp4 = client.call!("validator1.arrayOfStructsTest", int)(arrayOfStructs);
   writefln("array %s", resp4);
}
