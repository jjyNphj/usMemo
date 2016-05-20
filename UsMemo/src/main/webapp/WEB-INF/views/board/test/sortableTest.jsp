<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Your Board</title>
	<!-- <script src="//code.jquery.com/jquery-1.10.2.js"></script> -->
	<script src="${pageContext.request.contextPath}/js/jquery.js" type="text/javascript"></script>
  <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
</head>
<body>

<div class="list_all">
	<div class="li_list_unit">
			list! 1
			<div class="card_all">
				<div class="li_card" id="1-1">card! 1-1</div>
				<div class="li_card" id="1-2">card! 1-2</div>
				<div class="li_card" id="1-3">card! 1-3</div>
			</div>
		</div>
		<div class="li_list_unit">
			list! 2
			<div class="card_all">
				<div class="li_card" id="2-1">card! 2-1</div>
				<div class="li_card" id="2-2">card! 2-2</div>
				<div class="li_card" id="2-3">card! 2-3</div>
			</div>
		</div>
			<div class="li_list_unit">
			list! 3
			<div class="card_all">
				<div class="li_card" id="3-1">card! 3-1</div>
				<div class="li_card" id="3-2">card! 3-2</div>
				<div class="li_card" id="3-3">card! 3-3</div>
			</div>
		</div>
</div>



	<script type="text/javascript">
	$(function() {
		$(".list_all").sortable({
			item:function(event, ui) {    
	               var productOrder = $(this).sortable("toArray");
		              console.log("item:"+productOrder);
		              }
			,
			position:function(event, ui) {    
	            var productOrder = $(this).sortable("toArray");
	            console.log("position: "+productOrder);
	            }
			,
			originalPosition:function(event, ui) {    
			    var productOrder = $(this).sortable("toArray");
			    console.log("originalPosition:"+ui.item.index());
			    }
			,
			  start: function (event, ui) {  
				  var productOrder = $(this).sortable("toArray");
				  console.log("item:"+productOrder);
				  
		        },
		        stop: function (event, ui) {
		        	 var productOrder = $(this).sortable("toArray");
		    		
		        },
			update: function(event, ui) {    
	               var productOrder = $(this).sortable("toArray");
	              console.log("List update : "+productOrder);
	            },
	            beforeStop: function( event, ui ) {console.log("item:"+ui.item.index());},
	            change: function( event, ui ) { console.log("change: "+ui.item[0].id);}
	           
		}).disableSelection();
		$(".card_all").sortable({
			 connectWith: ".card_all",
				item:function(event, ui) {    
		               var productOrder = $(this).sortable("toArray");
			              console.log("item:"+productOrder);
			              }
				,
				position:function(event, ui) {    
		            var productOrder = $(this).sortable("toArray");
		            console.log("position: "+productOrder);
		            }
				,
				originalPosition:function(event, ui) {    
				    var productOrder = $(this).sortable("toArray");
				    console.log("originalPosition:"+ui.item.index());
				    }
				,
				  start: function (event, ui) {  
					  var productOrder = $(this).sortable("toArray");
					  console.log("item:"+productOrder);
					  
			        },
			        stop: function (event, ui) {
			        	 var productOrder = $(this).sortable("toArray");
			    		
			        },
				update: function(event, ui) {    
		               var productOrder = $(this).sortable("toArray");
		              console.log("List update : "+productOrder);
		            },
		            beforeStop: function( event, ui ) {console.log("item:"+ui.item.index());},
		            change: function( event, ui ) { console.log("change: "+ui.item[0].id);}
		           
		}).disableSelection();
	});
	</script>
	
</body>
</html>