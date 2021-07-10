document.addEventListener("DOMContentLoaded", function () {
  $(document).on("click","[id^=hole_btn]",function() {
    if (document.querySelector("#hole_number_field_1").value == 1) {
      document.querySelector("#hole_number_field_1").value = 10;
      document.querySelector("#hole_number_field_2").value = 11;
      document.querySelector("#hole_number_field_3").value = 12;
      document.querySelector("#hole_number_field_4").value = 13;
      document.querySelector("#hole_number_field_5").value = 14;
      document.querySelector("#hole_number_field_6").value = 15;
      document.querySelector("#hole_number_field_7").value = 16;
      document.querySelector("#hole_number_field_8").value = 17;
      document.querySelector("#hole_number_field_9").value = 18;
    } else {
      document.querySelector("#hole_number_field_1").value = 1;
      document.querySelector("#hole_number_field_2").value = 2;
      document.querySelector("#hole_number_field_3").value = 3;
      document.querySelector("#hole_number_field_4").value = 4;
      document.querySelector("#hole_number_field_5").value = 5;
      document.querySelector("#hole_number_field_6").value = 6;
      document.querySelector("#hole_number_field_7").value = 7;
      document.querySelector("#hole_number_field_8").value = 8;
      document.querySelector("#hole_number_field_9").value = 9;
    }
  })
});
