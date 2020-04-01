
//UserAgent variables
var deviceUserAgent = (/Android|webOS|iPhone|iPad|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)),
        IEuserAgent = (document.documentMode || /Edge/.test(navigator.userAgent));

// Site Pre-Loader
// makes sure the whole site is loaded
$(window).on('load', function() {
  // will first fade out the loading animation
    $("#status").velocity('fadeOut');
  // will fade out the whole DIV that covers the website.
    $("#preloader").velocity('fadeOut', { duration: 1000 })
});

//Manage the Content Area
$(window).on('load resize', function(){
    var winHeight = $(window).height(), 
    headerHeight = $('.header-section').height(),
    footerHeight = $('.footer-section').height(),
    calcHeight = 0;
    calcHeight = winHeight - (headerHeight+footerHeight);
    $('.listing-section').css('min-height', calcHeight);
    $('.inner-section').css('min-height', calcHeight);
});

//Sticky Section
if(!deviceUserAgent){
    $(window).on('scroll', function() {
        var scroll = $(window).scrollTop(),
            headerHeight = $('.header-section').height();
        if (scroll > headerHeight) {
            $('#scrollFixed').addClass('section-sticky');
        } 
        else {
            $('#scrollFixed').removeClass('section-sticky');
        }
    });
}

$(document).ready(function() {

	//User Menu
	$('#usermenu-toggle').on('click', function(e){
		e.stopPropagation();
        e.preventDefault();
        $('.usermenu-submenu').slideToggle('200');
	});
	$('body').on('click', function(e) {
	    var target = $(e.target);
	    if (!target.is('.usermenu-submenu') && !target.is('.usermenu-submenu *')) {
	        if ($('.usermenu-submenu').is(':visible')) {
	        	$('.usermenu-submenu').velocity('slideUp', { duration: 400 });
	        } 
	    }
    });
    

    //Bootstarap DatePicker
    $('#createDate').datetimepicker({
        format: 'DD/MM/YYYY',
        defaultDate: '06/06/2016'
    });
    $('#reportDate').datetimepicker({
        format: 'DD/MM/YYYY'
    });
    $('#dueDate').datetimepicker({
        format: 'DD/MM/YYYY'
    });
    $('#popupcreateDate').datetimepicker({
        format: 'DD/MM/YYYY',
        defaultDate: '06/06/2016'
    });
    $('#popuprevisedDate').datetimepicker({
        format: 'DD/MM/YYYY',
        defaultDate: '06/06/2016'
    });

    //typeHead
    $('#siteLeadSuggestions').typeahead({
        source: [
            { id: 1, name: 'Doreen Coblentz' },
            { id: 2, name: 'Noelia Keppel' },
            { id: 3, name: 'Jerrell Bailes' },
            { id: 4, name: 'Arron Stayton' },
            { id: 5, name: 'Selma Yohe' },
            { id: 6, name: 'Emanuel Locher' },
            { id: 7, name: 'Vella Farrah' },
            { id: 8, name: 'Josefine Thornton' },
            { id: 9, name: 'Verda Linnell' },
            { id: 10, name: 'Laura Rase' }
        ]
    });
    $('#siteLead2Suggestions').typeahead({
        source: [
            { id: 1, name: 'Doreen Coblentz' },
            { id: 2, name: 'Noelia Keppel' },
            { id: 3, name: 'Jerrell Bailes' },
            { id: 4, name: 'Arron Stayton' },
            { id: 5, name: 'Selma Yohe' },
            { id: 6, name: 'Emanuel Locher' },
            { id: 7, name: 'Vella Farrah' },
            { id: 8, name: 'Josefine Thornton' },
            { id: 9, name: 'Verda Linnell' },
            { id: 10, name: 'Laura Rase' }
        ]
    });


    //Accordion
    $('.accordion-list-group').accordion({
        accordion:true,
        speed: 400
    });
    
});