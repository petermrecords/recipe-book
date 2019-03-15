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

	$("body").on("click",".clickable-row", function(event) {
		window.location.href = $(this).find("a").attr("href");
	});

	$("body").on("click",".link-unstyled", function(event) {
		event.preventDefault();
	});

	$("body").on("click",".nav-link", function(event) {
		if (!($(this).hasClass("no-disable"))) {
			$(this).parent().parent().find("li.nav-item a").removeClass("disabled");
			$(this).addClass("disabled");
		}
	});

	$("body").on("click",".collapse-button", function(event) {
		if ($(this).hasClass("open")) {
			$(this).css({"transform": "rotate(0deg)"});
			$(this).removeClass("open");
		} else {
			$(this).css({"transform": "rotate(180deg)"});
			$(this).addClass("open");
		}
		$(this).blur();
	});

	$("body").on("click","#head-collapse-button", function(event) {
		if ($(this).hasClass("collapsed")) {
			$(".head-collapse-content").removeClass("hidden");
			$(this).removeClass("collapsed");
		} else {
			$(".head-collapse-content").addClass("hidden");
			$(this).addClass("collapsed");
		}
		$(this).blur();
	});

	$("body").on("change",".custom-file-input", function(event)  {
		var fileName = $(this).val().split("\\").pop();
		$(this).parent().find("label").html(fileName);
	});
});