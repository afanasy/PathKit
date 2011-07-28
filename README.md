# PathKit

PathKit is a RESTful interface to NSDictionary and NSArray, written in Objective-C

## get

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

## post

*-(void)post:path this:(id)value;*

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

## delete

*-(void)delete:(id)path;*

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

## merge

*-(void)merge:(id)value;*

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

# License

*FreeBSD license*

    Copyright 2011 Afanasy Kurakin. All rights reserved.
    
    Redistribution and use in source and binary forms, with or without modification, are
    permitted provided that the following conditions are met:
    
       1. Redistributions of source code must retain the above copyright notice, this list of
          conditions and the following disclaimer.
    
       2. Redistributions in binary form must reproduce the above copyright notice, this list
          of conditions and the following disclaimer in the documentation and/or other materials
          provided with the distribution.
    
    THIS SOFTWARE IS PROVIDED BY AFANASY KURAKIN ''AS IS'' AND ANY EXPRESS OR IMPLIED
    WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
    FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL AFANASY KURAKIN OR
    CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
    CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
    SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
    ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
    NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
    ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
    
    The views and conclusions contained in the software and documentation are those of the
    authors and should not be interpreted as representing official policies, either expressed
    or implied, of Afanasy Kurakin.