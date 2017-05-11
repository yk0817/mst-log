/* eslint no-console: 0 */
// Run this example by adding <%= javascript_pack_tag 'hello_vue' %>
// to the head of your layout file,
// like app/views/layouts/application.html.erb.
// All it does is render <div>Hello Vue</div> at the bottom of the page.

import Vue from 'vue/dist/vue.esm'
import App from './app.vue'

var search_width_flag = true;

if (search_width_flag){
  window.addEventListener('resize', function () {
    let windowWidth = window.innerWidth;
    if (windowWidth < 768 && search_width_flag) {
      document.querySelector(".example-body-wrapper > div.grid").classList.remove("grid");
      search_width_flag = false;
    } else if (windowWidth > 768 && !search_width_flag) {
      document.querySelector(".example-body-wrapper > div").classList.add("grid");
      search_width_flag = true;
    }
  });
};

if (search_width_flag){
  window.addEventListener('load', function () {
    let windowWidth = window.innerWidth;
    if (windowWidth < 768 && search_width_flag) {
      document.querySelector(".example-body-wrapper > div.grid").classList.remove("grid");
      search_width_flag = false;
    } else if (windowWidth > 768 && !search_width_flag) {
      document.querySelector(".example-body-wrapper > div").classList.add("grid");
      search_width_flag = true;
    }
  });
};

