// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import 'bootstrap';
import '../../../node_modules/bootstrap/dist/css/bootstrap.css';
import $ from 'jquery';
global.$ = jQuery = $;

//= require recipe