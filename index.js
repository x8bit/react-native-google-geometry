
import { NativeModules } from 'react-native';

const { RNGoogleGeometry } = NativeModules;

const containsLocation  = async (point,polygon)=>{
    let isInLocation = await RNGoogleGeometry.containsLocation(point,polygon)
    if(isInLocation){
        return true
    }else{
        return false
    }
}

const decode  = async (encodedPath)=>{
    let polyLine = await RNGoogleGeometry.decode(encodedPath)
    return polyLine;
}

export default { containsLocation, decode }