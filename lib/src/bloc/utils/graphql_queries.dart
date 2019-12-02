class Queries {
  static const login = """
        query login(\$usernameOrEmail: String!, \$password: String!) {
          login(usernameOrEmail: \$usernameOrEmail, password: \$password) {
          token
            username
            fullname
            email
            role {
                name
            }
            id
            phone
            profileImageId
            driver{
              id
              name
              score
              userId
              phone
            }
          }
        }
         """;
  static const demandsList = Fragments.demandResults +
      """
        query DemandList(\$states: [DemandState]){
           demandsByStatesV2(                    
             states: \$states                     
            ){                                   
              ...results                                
            }                                    
          }                                        
         """;

  static const demandsByDriver = Fragments.demandResults +
      """
        query DemandList(\$states: [DemandState]){
           demandsByStatesWithoutDate(                    
             states: \$states                     
            ){                                   
              ...results                                
            }                                    
          }                                        
         """;
}

class Mutations {
  static const acceptDemand = """
   mutation acceptDemand (\$demandId: ID!){
   demandAccepted (demandId:\$demandId) {
     id
     state
   }
 }
  """;

  static const cancelDemand = """
mutation cancelDemand (\$demandId: ID!, \$reason: String, \$canceledType: CanceledType!){
    cancelDemandByDriver(demandId:\$demandId, reason:\$reason, canceledType:\$canceledType) {
      id
    }
 }
  """;

  static const startDemand = Fragments.demandResults +
      """
  mutation startDemand (\$demandId: ID!){
   demandStarted (demandId:\$demandId) {
     ...results
   }
 }
  """;
}

class Fragments {
  static const demandResults = """
  fragment results on Demand{   
    id                        
    date                      
    originAddress {           
        addressText           
        latitude              
        longitude             
    }                         
    destinationAddress {      
        addressText           
        latitude              
        longitude             
    }                         
    client{                   
        id                    
        fullname              
        phone                 
    }                         
    lostFound{                
       description            
    }                         
    state                     
    annotation                
    driverAnnotation          
    price                     
    driver{                   
        name                  
        userId                
                              
    }                         
    callCenterId              
    alarmTimeBefore           
    canceledType              
  }
                           
  """;
}
