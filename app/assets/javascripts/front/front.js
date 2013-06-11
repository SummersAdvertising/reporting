$(document).ready(function(){
	/* part1 */
  	$('#add-button').click(function(){
  		$('#topic-add').stop().toggle(500,function(){
  			$('#del-button').addClass('dark')
  		});	
  	})

  	$('#del-button').click(function(){
  		$(this).hide();
  		$('#check-button').show();
  		$('#add-button').addClass('dark');
  		$('.del').stop().fadeIn(500)
  	})

  	$('#check-button').hide().click(function(){
		$(this).hide();
		$('#del-button').show();
		$('#add-button').removeClass('dark');
		$('.del').stop().fadeOut(500)	
	})
	
	$('#aside-ctrl').click(function(){
		$('aside').animate({left:0}, function(){
			$('article').addClass('mask');
			$(document).click(function(){
				$('aside').animate({left:-200});
				$('article').removeClass('mask');
				$(document).unbind();
			});
		});
	})
	
	$('#tool-ctrl')	.click(function(){
		$('#tool-list').fadeIn('slow', function(){
			$(document).click(function() {
				$('#tool-list').fadeOut();
				$(document).unbind();
			});
		});	
	})

	/* part2 */
	$(function(){	
		var _showTab = 0;
		var $defaultLi = $('.tab li').eq(_showTab).addClass('active');
		$($defaultLi.find('a').attr('href')).siblings().hide();
 		$('.tab li').click(function() {		
			var $this = $(this),
			_clickTab = $this.find('a').attr('href');		
			$this.addClass('active').siblings('.active').removeClass('active');		
			$(_clickTab).stop(false, true).fadeIn().siblings().hide(); 
			return false;
		}).find('a').focus(function(){
			this.blur();
		});
	});
	
	$('.tab-content').hide()
	$('.option .tab').hide()
	$('#main-text').click(function(){
		$('.option .tab').fadeIn()		
	})
	$('.option .tab a').click(function(){
		$('.tab-content').fadeIn()		
	})
	$('.box-edit').hide()
	$('#tool-edit').click(function(){
		$('.box-edit').fadeIn(0)		
		$('.box-show').fadeOut(0)	
	})

	/* aside adjusts height */
	var adjustHeight = $("article").outerHeight();
	var windowHeight = $(window).height();
	$("#wrapper aside").css("height", adjustHeight>windowHeight? adjustHeight:windowHeight );
});