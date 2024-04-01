public with sharing class ReadTrackFieldStaticFiles {
 
    public Map<String, Set<String>> contentStaticFile = new Map<String, Set<String>>(); 
  //public Map<String, Set<String>> contentStaticFile2= new Map<String, Set<String>>(); 
    //Function to mapping all data load from static resource file

    public Map<String,Set<String>> loadTrackFieldStaticFile( ){
        String contents = [select id,body from StaticResource Where Name = 'TrackField'].body.toString();

        for(String line : contents.split('\n')) {  
            //contentStaticFile2 = contentStaticFile2.equals(new Map<String, Set<String>>()) ? new Map<String, Set<String>>{line.substringBefore('.') => new Set<String>{line.substringAfter('.')}} : contentStaticFile2.get(line.substringBefore('.')).put(line.substringBefore('.'), new Set<String>{line.substringAfter('.')});
            //contentStaticFile2 = contentStaticFile2.equals(new Map<String, Set<String>>()) ? new Map<String, Set<String>>{line.substringBefore('.') => new Set<String>{line.substringAfter('.')}} : new Map<String, Set<String>>{line.substringBefore('.') => contentStaticFile2.get(line.substringBefore('.')), line.substringBefore('.') => new Set<String>{line.substringAfter('.')}};
            if(!contentStaticFile.containsKey(line.substringBefore('.'))){
                contentStaticFile.put(line.substringBefore('.'), new Set<String>{line.substringAfter('.')});
            } else{
                contentStaticFile.get(line.substringBefore('.')).add(line.substringAfter('.'));
            }               
            
        }
    //system.debug('contentStaticFile'+contentStaticFile);
        //system.debug('contentStaticFile2'+contentStaticFile2);
        
        return contentStaticFile;
    }

    
    //Function called to check if the object of the trigger is in the file
    
    public Set<String> checkObjectInFile(String objectName){
        Set<String> fields = new Set<String>();
        contentStaticFile = loadTrackFieldStaticFile();   

        if(contentStaticFile.containsKey(objectName)){
            fields = contentStaticFile.get(objectName);  
                         
        }
        return fields;
      
    }

}