//営業活動実績チェックボックスon/off
function check_all() {
  if($("#all_list:checked").val()){
    $('input[type="checkbox"]').not(":disabled").prop({'checked' :true});
  }else{
    $('input[type="checkbox"]').prop({'checked' :false});
  }
};

//営業活動推移（顧客）チェックボックスon/off
function check_all_customer() {
  if($("#all_list_customer:checked").val()){
    $('input[type="checkbox"]').not(":disabled").prop({'checked' :true});
  }else{
    $('input[type="checkbox"]').prop({'checked' :false});
  }
};

//営業活動推移（新車受注）チェックボックスon/off
function check_all_percentage_newcar() {
  if($("#all_list_percentage_newcar:checked").val()){
    $('input[type="checkbox"]').not(":disabled").prop({'checked' :true});
  }else{
    $('input[type="checkbox"]').prop({'checked' :false});
  }
};

//営業活動推移（新車登録）チェックボックスon/off
function check_all_percentage_registration() {
  if($("#all_list_percentage_registration:checked").val()){
    $('input[type="checkbox"]').not(":disabled").prop({'checked' :true});
  }else{
    $('input[type="checkbox"]').prop({'checked' :false});
  }
};

//営業活動推移（中古車）チェックボックスon/off
function check_all_percentage_usedcar() {
  if($("#all_list_percentage_usedcar:checked").val()){
    $('input[type="checkbox"]').not(":disabled").prop({'checked' :true});
  }else{
    $('input[type="checkbox"]').prop({'checked' :false});
  }
};

//営業活動推移（12点検・24点検）チェックボックスon/off
function check_all_percentage_years() {
  if($("#all_list_percentage_years:checked").val()){
    $('input[type="checkbox"]').not(":disabled").prop({'checked' :true});
  }else{
    $('input[type="checkbox"]').prop({'checked' :false});
  }
};

//営業活動推移（車検）チェックボックスon/off
function check_all_percentage_inspection() {
  if($("#all_list_percentage_inspection:checked").val()){
    $('input[type="checkbox"]').not(":disabled").prop({'checked' :true});
  }else{
    $('input[type="checkbox"]').prop({'checked' :false});
  }
};

//営業活動推移（任意保険）チェックボックスon/off
function check_all_percentage_insurance_renew() {
  if($("#all_list_percentage_insurance_renew:checked").val()){
    $('input[type="checkbox"]').not(":disabled").prop({'checked' :true});
  }else{
    $('input[type="checkbox"]').prop({'checked' :false});
  }
};

//検索条件クリア
function clearSearchForm() {
    for(var i=0; i<search_form.elements.length; ++i) {
        clearElement(search_form.elements[i]);
    }
}
function clearElement(element) {
    switch(element.type) {
        case "hidden":
            element.value = "";
            return;
        case "submit":
        case "reset":
        case "button":
        case "image":
            return;
        case "file":
            return;
        case "text":
        case "password":
        case "textarea":
            element.value = "";
            return;
        case "checkbox":
        case "radio":
            element.checked = false;
            return;
        case "select-one":
        case "select-multiple":
            element.selectedIndex = 0;
            return;
        default:
    }
}

//操作ログの登録
function set_action_name(action_name){
   $.ajax({
   	url: "/logins/set_action_name",
   　  type: "GET",
    dataType: "text",
    cache: false,
    async: false,
    timeout: 5000,
    data: { action_name: action_name }
    });
}
$(function(){
  $('input.btn, button, a').not('.reload_with_format_csv').not('#get_address_button').click(
    function(){ 
    　　var action_name = $(this).text();
       if($(this).get(0).nodeName == "INPUT"){
         action_name = $(this).val();
        }
       set_action_name(action_name)
    }
  )
});

//jquery ie8対応
if (!Array.prototype.reduce) {
  Array.prototype.reduce = function reduce(accumulator){
    if (this===null || this===undefined) throw new TypeError("Object is null or undefined");
 
    var i = 0, l = this.length >> 0, curr;
 
    if(typeof accumulator !== "function") // ES5 : "If IsCallable(callbackfn) is false, throw a TypeError exception."
      throw new TypeError("First argument is not callable");
 
    if(arguments.length < 2) {
      if (l === 0) throw new TypeError("Array length is 0 and no second argument");
      curr = this[0];
      i = 1; // start accumulating at the second element
    }
    else
      curr = arguments[1];
 
    while (i < l) {
      if(i in this) curr = accumulator.call(undefined, curr, this[i], i, this);
      ++i;
    }
 
    return curr;
  };
}

//jquery ie8対応
if (!Array.indexOf) {
    Array.prototype.indexOf = function(o) {
        for (var i in this) {
            if (this[i] == o) {
                return i;
            }
        }
        return -1;
    }
}

//jquery ie8対応
String.prototype.trim = function() {
    return this.replace(/^[\s　]+|[\s　]+$/g, '');
}
