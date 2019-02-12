//============================== header =========================

jQuery(document).ready(function($) {

    var navbar = $('.navbar-main'),
    		distance = navbar.offset().top,
        $window = $(window);

	    $window.scroll(function() {
	    	if(($window.scrollTop() >= distance) && ($(".navbar-default").hasClass("navbar-main")))
	        {
	            navbar.removeClass('navbar-fixed-top').addClass('navbar-fixed-top');
	          	$("body").addClass("padding-top");
	          	$(".topBar").css("display","none");
	        } else {
	            navbar.removeClass('navbar-fixed-top');
	            $("body").removeClass("padding-top");
	            $(".topBar").css("display","block");
	        }
	    });

});

//============================== ALL DROPDOWN ON HOVER =========================
jQuery(document).ready(function(){
    $('.dropdown').hover(function() {
        $(this).addClass('open');
    },
    function() {
        $(this).removeClass('open');
    });
});
//============================== RS-SLIDER =========================
jQuery(document).ready(function() {
	  jQuery('.fullscreenbanner').revolution({
		delay: 5000,
		startwidth: 1170,
		startheight: 500,
		fullWidth: "on",
		fullScreen: "off",
		hideCaptionAtLimit: "",
		dottedOverlay: "twoxtwo",
		navigationStyle: "preview4",
		fullScreenOffsetContainer: "",
		hideTimerBar:"on",
	});
});

//============================== OWL-CAROUSEL =========================
jQuery(document).ready(function() {
	var owl = $('.owl-carousel.featuredProductsSlider');
	  owl.owlCarousel({
		  loop:true,
		  margin:28,
		  autoplay:true,
		  autoplayTimeout:2000,
		  autoplayHoverPause:true,
		  nav:true,
		  moveSlides: 4,
		  dots: false,
		  responsive:{
			  320:{
				  items:1
			  },
			  768:{
				  items:3
			  },
			  992:{
			  	items:4
			  }
		  }
	  });
	var owl = $('.owl-carousel.partnersLogoSlider');
	  owl.owlCarousel({
		  loop:true,
		  margin:28,
		  autoplay:true,
		  autoplayTimeout:6000,
		  autoplayHoverPause:true,
		  nav:true,
		  dots: false,
		  responsive:{
			  320:{
			  	slideBy: 1,
				  items:1
			  },
			  768:{
			  	slideBy: 3,
				  items:3
			  },
			  992:{
			  	slideBy: 5,
				  items:5
			  }
		  }
	  });
});
//============================== SELECT BOX =========================
jQuery(document).ready(function() {
	$('.select-drop').selectbox();
});

//============================== SIDE NAV MENU TOGGLE =========================
jQuery(document).ready(function() {
	$('.side-nav li a').click(function() {
		$(this).find('i').toggleClass('fa fa-minus fa fa-plus');
	});
});

//============================== PRICE SLIDER RANGER =========================
jQuery(document).ready(function() {
	var minimum = 2000;
	var maximum = 30000;

	$( "#price-range" ).slider({
		range: true,
		min: minimum,
		max: maximum,
		values: [ minimum, maximum ],
		slide: function( event, ui ) {
			$( "#price-amount-1" ).val( ui.values[ 0 ] + "円" );
			$( "#price-amount-2" ).val( ui.values[ 1 ] + "円" );
		}
	});

	$( "#price-amount-1" ).val( $( "#price-range" ) .slider( "values", 0 ) + "円");
	$( "#price-amount-2" ).val( $( "#price-range" ) .slider( "values", 1 ) + "円");
});
//============================== PRODUCT SINGLE SLIDER =========================
jQuery(document).ready(function() {
	(function($){
	  $('#thumbcarousel').carousel(0);
	  var $thumbItems = $('#thumbcarousel .item');
	    $('#carousel').on('slide.bs.carousel', function (event) {
	     var $slide = $(event.relatedTarget);
	     var thumbIndex = $slide.data('thumb');
	     var curThumbIndex = $thumbItems.index($thumbItems.filter('.active').get(0));
	    if (curThumbIndex>thumbIndex) {
	      $('#thumbcarousel').one('slid.bs.carousel', function (event) {
	        $('#thumbcarousel').carousel(thumbIndex);
	      });
	      if (curThumbIndex === ($thumbItems.length-1)) {
	        $('#thumbcarousel').carousel('next');
	      } else {
	        $('#thumbcarousel').carousel(numThumbItems-1);
	      }
	    } else {
	      $('#thumbcarousel').carousel(thumbIndex);
	    }
	  });
	})(jQuery);
});

jQuery(document).ready(function() {
	$(".quick-view .btn-block").click(function(){
        $(".quick-view").modal("hide");
    });
});
function FormSubmit() {
    var target = document.getElementById("form01");
    target.method = "post";
    target.submit();
  };


//============================== FOOTER COPYRIGHT =========================

// コンテンツが少ない時にfooterをbottom:0にする footerFixed.js
  new function(){

  	var footerId = "footer";
  	//メイン
  	function footerFixed(){
  		//ドキュメントの高さ
  		var dh = document.getElementsByTagName("body")[0].clientHeight;
  		//フッターのtopからの位置
  		document.getElementById(footerId).style.top = "0px";
  		var ft = document.getElementById(footerId).offsetTop;
  		//フッターの高さ
  		var fh = document.getElementById(footerId).offsetHeight;
  		//ウィンドウの高さ
  		if (window.innerHeight){
  			var wh = window.innerHeight;
  		}else if(document.documentElement && document.documentElement.clientHeight != 0){
  			var wh = document.documentElement.clientHeight;
  		}
  		if(ft+fh<wh){
  			document.getElementById(footerId).style.position = "relative";
  			document.getElementById(footerId).style.top = (wh-fh-ft-1)+"px";
  		}
  	}

  	//文字サイズ
  	function checkFontSize(func){

  		//判定要素の追加
  		var e = document.createElement("div");
  		var s = document.createTextNode("S");
  		e.appendChild(s);
  		e.style.visibility="hidden"
  		e.style.position="absolute"
  		e.style.top="0"
  		document.body.appendChild(e);
  		var defHeight = e.offsetHeight;

  		//判定関数
  		function checkBoxSize(){
  			if(defHeight != e.offsetHeight){
  				func();
  				defHeight= e.offsetHeight;
  			}
  		}
  		setInterval(checkBoxSize,1000)
  	}

  	//イベントリスナー
  	function addEvent(elm,listener,fn){
  		try{
  			elm.addEventListener(listener,fn,false);
  		}catch(e){
  			elm.attachEvent("on"+listener,fn);
  		}
  	}

  	addEvent(window,"load",footerFixed);
  	addEvent(window,"load",function(){
  		checkFontSize(footerFixed);
  	});
  	addEvent(window,"resize",footerFixed);

  }
