P3109 formats (in csv files) 
    bitwidth:    2 .. 15,             (binary2s appear as a reference)
    signedness:  signed, unsigned 
    domain:      finite, extended

These compressed files are available via dropbox.

    P3109_formats_K2K8_base16.zip     0.5MB     binary2s ... binary8s
    P3109_formats_K2K8_base10.zip     0.5MB     binary2s ... binary8s

    P3109_formats_K2K12_base16.zip    1.0MB     binary2s ... binary12s
    P3109_formats_K2K12_base10.zip    2.5MB     binary2s ... binary12s

    P3109_formats_K2K15_base16.zip    8.5MB     binary2s ... binary15s
    P3109_formats_K2K15_base10.zip   33.5MB     binary2s ... binary15s

    compressed file sizes are +/- 0.25MB


the directory structure and content shown for ./bits4

for _base10 zips                     for _base16 zips

bits4                                bits4
       signed                                signed
                 binary4se.csv                        binary4se.hex.csv
                 binary4sf.csv                        binary4sf.hexcsv
       unsigned                              unsigned
                 binary4ue.csv                        binary4ue.hex.csv
                 binary4uf.csv                        binary4uf.hex.csv

file format notes

   All have the file extension .csv
   All use comma separated values.
   
   The first line holds column names
   The first column is named "code"
     for formats not more than 8 bits, the encodings are 8-bit hexadecimals
     for formats wider than 8 bits, the encodings are 16-bit hexadecimals

   Subsequent lines hold the data.   
   The last line is a newline character, nothing more

   There is a single space at the start of each line
      this includes the first line with column names 
      (except for the last, which is empty, just a '\n').

   Each column is spaced so all commas align.
   Each comma is followed by a single space and
      preceded by one or more spaces.
    
   Infinity is written Inf
   Not-a-Number is written NaN

sample files

binary4se.hex.csv:

 code  , binary4p1se , binary4p2se , binary4p3se 
 0x01  , 0x1p-3      , 0x1p-2      , 0x1p-2      
 0x02  , 0x1p-2      , 0x1p-1      , 0x1p-1      
 0x03  , 0x1p-1      , 0x1.8p-1    , 0x1.8p-1    
 0x04  , 0x1p+0      , 0x1p+0      , 0x1p+0      
 0x05  , 0x1p+1      , 0x1.8p+0    , 0x1.4p+0    
 0x06  , 0x1p+2      , 0x1p+1      , 0x1.8p+0    
 0x07  , Inf         , Inf         , Inf         
 0x08  , NaN         , NaN         , NaN         
 0x09  , -0x1p-3     , -0x1p-2     , -0x1p-2     
 0x0a  , -0x1p-2     , -0x1p-1     , -0x1p-1     
 0x0b  , -0x1p-1     , -0x1.8p-1   , -0x1.8p-1   
 0x0c  , -0x1p+0     , -0x1p+0     , -0x1p+0     
 0x0d  , -0x1p+1     , -0x1.8p+0   , -0x1.4p+0   
 0x0e  , -0x1p+2     , -0x1p+1     , -0x1.8p+0   
 0x0f  , -Inf        , -Inf        , -Inf

binary4se.csv:

 code  , binary4p1se , binary4p2se , binary4p3se 
 0x01  , 0.125       , 0.25        , 0.25        
 0x02  , 0.25        , 0.5         , 0.5         
 0x03  , 0.5         , 0.75        , 0.75        
 0x04  , 1           , 1           , 1           
 0x05  , 2           , 1.5         , 1.25        
 0x06  , 4           , 2           , 1.5         
 0x07  , Inf         , Inf         , Inf         
 0x08  , NaN         , NaN         , NaN         
 0x09  , -0.125      , -0.25       , -0.25       
 0x0a  , -0.25       , -0.5        , -0.5        
 0x0b  , -0.5        , -0.75       , -0.75       
 0x0c  , -1          , -1          , -1          
 0x0d  , -2          , -1.5        , -1.25       
 0x0e  , -4          , -2          , -1.5        
 0x0f  , -Inf        , -Inf        , -Inf        

binary4uf.hex.csv:

 code  , binary4p1se , binary4p2se , binary4p3se 
 0x01  , 0x1p-3      , 0x1p-2      , 0x1p-2      
 0x02  , 0x1p-2      , 0x1p-1      , 0x1p-1      
 0x03  , 0x1p-1      , 0x1.8p-1    , 0x1.8p-1    
 0x04  , 0x1p+0      , 0x1p+0      , 0x1p+0      
 0x05  , 0x1p+1      , 0x1.8p+0    , 0x1.4p+0    
 0x06  , 0x1p+2      , 0x1p+1      , 0x1.8p+0    
 0x07  , Inf         , Inf         , Inf         
 0x08  , NaN         , NaN         , NaN         
 0x09  , -0x1p-3     , -0x1p-2     , -0x1p-2     
 0x0a  , -0x1p-2     , -0x1p-1     , -0x1p-1     
 0x0b  , -0x1p-1     , -0x1.8p-1   , -0x1.8p-1   
 0x0c  , -0x1p+0     , -0x1p+0     , -0x1p+0     
 0x0d  , -0x1p+1     , -0x1.8p+0   , -0x1.4p+0   
 0x0e  , -0x1p+2     , -0x1p+1     , -0x1.8p+0   
 0x0f  , -Inf        , -Inf        , -Inf                

binary4p1uf.csv

 code  , binary4p1uf , binary4p2uf , binary4p3uf , binary4p4uf 
 0x01  , 0.0078125   , 0.0625      , 0.125       , 0.125       
 0x02  , 0.015625    , 0.125       , 0.25        , 0.25        
 0x03  , 0.03125     , 0.1875      , 0.375       , 0.375       
 0x04  , 0.0625      , 0.25        , 0.5         , 0.5         
 0x05  , 0.125       , 0.375       , 0.625       , 0.625       
 0x06  , 0.25        , 0.5         , 0.75        , 0.75        
 0x07  , 0.5         , 0.75        , 0.875       , 0.875       
 0x08  , 1           , 1           , 1           , 1           
 0x09  , 2           , 1.5         , 1.25        , 1.125       
 0x0a  , 4           , 2           , 1.5         , 1.25        
 0x0b  , 8           , 3           , 1.75        , 1.375       
 0x0c  , 16          , 4           , 2           , 1.5         
 0x0d  , 32          , 6           , 2.5         , 1.625       
 0x0e  , 64          , 8           , 3           , 1.75        
 0x0f  , NaN         , NaN         , NaN         , NaN         

 