// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require rails-ujs
//= require activestorage
//= require_tree .

$(document).ready(function() {
	
	$("#wizard-content").on("change", "#grocery_type", function(event) {
		$.ajax({
			url: '/groceries/selectbox',
			data: {
				grocery_type: this.value
			}
		});
	});

	$("#wizard-content").on("change","#measurement_type", function(event) {
		$.ajax({
			url: '/measurements/selectbox',
			data: {
				measurement_type: this.value
			}
		});
	});

	$("#modal-anchor").on("submit","#new_grocery", function(event) {
		$("#new-grocery-form").modal("toggle");
	});

	$("#modal-anchor").on("hidden.bs.modal","#new-grocery-form", function(event) {
		$("#modal-anchor").html("");
	});
});