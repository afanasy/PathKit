PathKit
=======

PathKit is a RESTful interface to NSDictionary and NSArray, written in Objective-C

get
---

*-(id)get:(id)path;*

    /*
    dictionary = {
     "this": "is",
     "dictionary: {
      "with":"dictionary",
       "and":[
       "an",
       "array",
       "inside"
      ]
     }
    }
    */

    [dictionary get:@"this"]; //returns @"is"
    [dictionary get:@"dictionary/with"]; //returns @"dictionary"
    [dictionary get:@"dictionary/and/2"]; //returns @"inside"

post
----

-(void)post:path this:(id)value;

    /*
    dictionary = {
     "this": "is",
     "dictionary: {
      "with":"dictionary",
       "and":[
       "an",
       "array",
       "inside"
      ]
     }
    }
    */

    [dictionary post:@"dictionary/some" this:@"keys"];
    
    //produces
    /*
    dictionary = {
     "this": "is",
     "dictionary: {
      "with":"dictionary",
      "some":"keys",
      "and":[
       "an",
       "array",
       "inside"
      ]
     }
    }
    */

delete
------

-(void)delete:(id)path;

    /*
    dictionary = {
     "this": "is",
     "dictionary: {
      "with":"dictionary",
       "and":[
       "an",
       "array",
       "inside"
      ]
     }
    }
    */

    [dictionary delete:@"dictionary/and"];
    
    //produces
    /*
    dictionary = {
     "this": "is",
     "dictionary: {
      "with":"dictionary"
     }
    }
    */

merge
-----

-(void)merge:(id)value;

    /*
    otherDictionary = {
     "this":{
      "is":[
       "other",
       "dictionary"
      ]
     }
    }
    */

    [dictionary merge:otherDictionary];

    //produces
    /*
    dictionary = {
     "this":{
      "is":[
       "other",
       "dictionary"
      ]
     },
     "dictionary: {
      "with":"dictionary",
      "and":[
       "an",
       "array",
       "inside"
      ]
     }
    }
    */