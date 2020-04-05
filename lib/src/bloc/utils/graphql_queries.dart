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
  static const acceptDemand = Fragments.demandResults +
      """
   mutation acceptDemand (\$demandId: ID!){
   demandAccepted (demandId:\$demandId) {
     ...results
   }
 }
  """;

  static const cancelDemand = """
  mutation cancelDemand (\$demandId: ID!, \$reason: String, \$canceledType: CanceledType!){
    cancelDemandByDriver(demandId:\$demandId, reason:\$reason, canceledType:\$canceledType) {
      ...results
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

  static const pickUpClient = Fragments.demandResults +
      """
  mutation pickUpClient (\$demandId: ID!){
    demandInCourse (demandId:\$demandId) {
    ...results
    }
  }
  """;

  static const finishDemand = Fragments.demandResults +
      """
  mutation finishDemand (\$demandId: ID!){
    demandFinished (demandId:\$demandId) {
    ...results
    }
  }
  """;

  static const declineDemand = Fragments.demandResults +
      """
  mutation DeclineDemand (\$demandId: ID!){
    demandNotifyAction(demandId: \$demandId, action:REFUSED)
}
  """;

  static const updateDriver = """
    mutation DriverUpdate(\$id: ID!, \$resource: DriverUpdateInput!){
      driverUpdateV2(id: \$id, resource: \$resource){
    	  id,
        name,
        state
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
