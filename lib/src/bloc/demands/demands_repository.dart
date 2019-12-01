import 'package:dtaxi_driver/src/bloc/demands/index.dart';
import 'package:dtaxi_driver/src/bloc/utils/response_model.dart';

class DemandsRepository {
  final DemandsProvider _demandsProvider = new DemandsProvider();

  DemandsRepository();

  Future<ResponseModel<Demand>> loadDemands({List<String> demandStates}) async {
    return await _demandsProvider.findAll("""
        query DemandList(\$states: [DemandState]){
           demandsByStatesV2(                    
             states: \$states                     
            ){                                   
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
          }                                        
         """, data: {
      "states": demandStates ?? [DemandType.SENDED]
    });
  }
}
