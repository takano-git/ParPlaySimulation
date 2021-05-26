window.onload = function() {
  const hole_btn = document.querySelector("#hole_btn");
  const hole_1 = document.querySelector("#hole_number_field_1");
  const hole_2 = document.querySelector("#hole_number_field_2");
  const hole_3 = document.querySelector("#hole_number_field_3");
  const hole_4 = document.querySelector("#hole_number_field_4");
  const hole_5 = document.querySelector("#hole_number_field_5");
  const hole_6 = document.querySelector("#hole_number_field_6");
  const hole_7 = document.querySelector("#hole_number_field_7");
  const hole_8 = document.querySelector("#hole_number_field_8");
  const hole_9 = document.querySelector("#hole_number_field_9");
  const hole_10 = document.querySelector("#hole_number_field_10");
  const hole_11 = document.querySelector("#hole_number_field_11");
  const hole_12 = document.querySelector("#hole_number_field_12");
  const hole_13 = document.querySelector("#hole_number_field_13");
  const hole_14 = document.querySelector("#hole_number_field_14");
  const hole_15 = document.querySelector("#hole_number_field_15");
  const hole_16 = document.querySelector("#hole_number_field_16");
  const hole_17 = document.querySelector("#hole_number_field_17");
  const hole_18 = document.querySelector("#hole_number_field_18");

  document.querySelector("#hole_btn").onclick =
  function () {
    if (hole_btn.value === 'OUT') {
      hole_btn.value = 'IN';
      hole_1.value = 10;
      hole_2.value = 11;
      hole_3.value = 12;
      hole_4.value = 13;
      hole_5.value = 14;
      hole_6.value = 15;
      hole_7.value = 16;
      hole_8.value = 17;
      hole_9.value = 18;
    } else {
      hole_btn.value = 'OUT';
      hole_1.value = 1;
      hole_2.value = 2;
      hole_3.value = 3;
      hole_4.value = 4;
      hole_5.value = 5;
      hole_6.value = 6;
      hole_7.value = 7;
      hole_8.value = 8;
      hole_9.value = 9;
    }
  }
};
