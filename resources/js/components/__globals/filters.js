import Vue from "vue";
require("moment-duration-format");
import TrashFieldDefs from '../__globals/trash_fields';
import CommonMethods from '../__globals/common-methods';
var converter = require('number-to-words');

/**
 * This filter is used to display two letter from name as icon!
 */
Vue.filter("nameToIcon", (input)=>{
    input = input.replace(/[^a-zA-Z ]/g, ""); //replace all special chars!
    var splits = input.split(" ");
    var words = []
    for(var x in splits){
        splits[x] = splits[x].trim();
        if(splits[x].length > 0){
            words.push(splits[x]);
        }
    }
    var result="";
    if(words.length >= 2){
        result = words[0][0]+words[1][0];
    }else{
        if(input.length >= 2){
            result= input[0]+input[1];
        }else{
            result= input[0];
        }
    }

    return result.toUpperCase();
});


Vue.filter("BGColorFormText", (styles) => {
    let text = styles.backgroundColor;
    let hash = 0;
    for (var i = 0; i < text.length; i++) {
        hash = text.charCodeAt(i) + ((hash << 5) - hash);
    }

    return 'background-color:'+`hsl(${hash % 360}, 80%, 90%)`;
});
Vue.filter("formatDate", (value,format) => {
    let formatDate = (format!= undefined)?format:'DD-MM-YYYY hh:mm A';
    return moment(String(value)).format(formatDate)
});
Vue.filter("durationFormat", (value) => {
    let durationSecond = moment.duration(value, 'seconds');
    return durationSecond.format("hh:mm:ss");
});
Vue.filter("nameToUpper", (value) => {
    return value.charAt(0).toUpperCase() + value.slice(1)
});
Vue.filter("formatCaseId", (id) => {
    return "C"+((""+id).padStart(3, "0"));
});
Vue.filter("generateDownloadUrl", (bugCatch) => {
    return '/bug_catcher/download/'+bugCatch.id;
});
Vue.filter("timer", (value) => {
    var hours =  parseInt(Math.floor(value / 3600));
    var minutes = parseInt(Math.floor((value - (hours * 3600)) / 60));
    var seconds= parseInt(value - (hours * 3600) - (minutes * 60));
    seconds = Math.round(seconds * 100) / 100;

    var dHours = (hours > 9 ? hours : '0' + hours);
    var dMins = (minutes > 9 ? minutes : '0' + minutes);
    var dSecs = (seconds > 9 ? seconds : '0' + seconds);

    return dHours + ":" + dMins + ":" + dSecs;
});
Vue.filter("trashText", (value) => {
    return TrashFieldDefs.findByValue(value).text;
});
Vue.filter("trashClass", (value) => {
    return TrashFieldDefs.findByValue(value).cssClass;
});
Vue.filter("rupeeWordConversion", (value) => {
    if( Number(value) ){
        let enteredNumber  = value.split(".");
        let words = converter.toWords(enteredNumber[0])+" rupees";
        if( enteredNumber[1] != undefined ){
            if( Number( enteredNumber[1] ))
            {
                words += " and "+converter.toWords(enteredNumber[1].substring(0, 2))+" paise";
            }
        }
        return words+"  only";
    }
    return 'In valid';
    /*console.log(Number(value));
    if (!value) return '';*/

});
Vue.filter("changePublicToStorage", (string) => {
    string.replace("public", "storage");
    return string;
});
Vue.filter("bindPrecisionRound", (value) => {
    return CommonMethods.precisionRound(value);
});
