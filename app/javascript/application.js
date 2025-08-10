// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "rails-ujs"
import jQuery from "jquery";
// jQuery를 전역 변수로 설정
window.$ = window.jQuery = jQuery;

import * as bootstrap from 'bootstrap';
window.Modal = bootstrap.Modal;

import 'common'
import 'index'
