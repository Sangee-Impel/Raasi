var bigDecimal = require('js-big-decimal');
export default {
    checkingMasterPassword(value) {
        axios.post('/api/master-passwords/checkingMasterPassword',{
                password_data : value
        })
            .then(response=>{
              return response.data;
            })
            .catch(reason=> {
            })
            .finally(response=>{
                self.isLoading = false;
            });
    },
    BigDecimalFunction(functionName,number1,number2){
        let result  =   new bigDecimal(0);
        let num1 = new bigDecimal(number1);
        let num2 = new bigDecimal(number2);
        switch (functionName){
            case "subtract":
                result = num1.subtract(num2);
                break;
            case "multiply":
                result = num1.multiply(num2);
                break;
            case "divide":
                result = num1.divide(num2);
                break;
            default:
                result =  num1.add(num2);
                break;
        }
        return this.precisionRound(result.value);//result.round().value;
    },
    CheckDifference(number1,number2){
        return bigDecimal.compareTo(number1, number2);
    },
    precisionRound(roundPaddingValue){
        let Configuration = JSON.parse($("#configuration").val());
        var precisions = 0;
        if( Configuration.precision != undefined )
            precisions = parseInt(Configuration.precision);
        return new bigDecimal(roundPaddingValue).round(precisions).value;
    }

}
