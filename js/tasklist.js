/**
 * javascript functions related to timetracking
 *
 * is been called on load
 *
 * included by:
 *
 * @author     Thomas Mann
 * @uses:
 * @usedby:
 */

// after loading...
$(function() {
   selectTaskInUrl();

   $('.new-task').each( function() {   
      var x= new NewTaskLine(this);
   });

   $('li.dragable').each(function() {
       makeListItemResortable(this);
   } );

   // The differentiation between these to intersecting list elements is done be comparing tagNames in the drop-function 
   $('div.task-group').each(function() {
      makeListItemResortable(this);
   });

   // Collapse groups
   $('.task-group .icon').click(function(e) 
   {
      var newValue = 0;
      if($(e.currentTarget).hasClass('open')) {
         console.log("is open!");   
         $(e.currentTarget).removeClass('open');
         newValue = 1;
      }
      else {
         console.log("is closed!");
         $(e.currentTarget).addClass('open');
      }
      var milestone_id = $(e.currentTarget).parents('.task-group').data('milestone-id');
      console.log('milestone_id:', milestone_id);


      $.post('index.php',{
        go: 'taskSetProperty',
        task_id: milestone_id,
        field_name: 'view_collapsed',
        value: newValue
      }, function(response) {
         console.log(response);
      });
      $(e.currentTarget).parents('div:first').find('ol').slideToggle();
   });

   // Use keyboard keys to cycle through tasks
   $('body').keydown(function(e) 
   {
      
      // ignore if a control has focus
      var $focused = $(':focus');
      if($focused.length > 0)
         return;

      var code = (e.keyCode ? e.keyCode : e.which);

      if(code == 40 || code == 38) {
         var selectedItems = $('li.dragable.selected').first();
         var selectedItem = selectedItems.length > 0 ? selectedItems[0] : null;         
         var items = $('li.dragable');
         var index = items.index(selectedItem);

         // down
         if (code == 40) {
            if(index < items.length -1) {
               selectListEntry( items[index+1]);
            }

         } 
         // up
         else if (code == 38) {
            if(index > 0) {
               selectListEntry( items[index-1]);
            }
         }   
         e.preventDefault();
      }
   });

});



function updateDetailsContainer(str)
{
   $('.details-container').html(str);
   $('.details-container div.wiki.editable').each(function() {
        aj= new AjaxWikiEdit(this);
        ajax_edits.push(aj);
        this.ajax_edit= aj;
   });

   $('.details-container h2.editable').each(function() {         
      aj= new AjaxTextFieldEdit(this);         
      this.ajax_edit= aj;
   });   

   // Update list item to hide new markers
   var task_id= $('.details-container h2').attr('item_id');  

   // Initialize inline parameter editing
   $('select.inline').change(function(e) {
      var field_name = $(this).data('field-name');
      $.post('index.php',{
         go:           $(this).data('url'),
         task_id:       task_id, 
         field_name:    field_name,
         value:         $(this).val(),         
      }, function(str) {
         updateListItemForTask(task_id);
      });
      if ( field_name == "for_milestone" ){
    	  $("#milestone-" + $(this).val()).append( $("#task-" + task_id) );
    	  $("#task-" + task_id).scrollintoview( { duration: 200 } );
      }
   });

   // Initialize comment form
   $('.details-container .new-comment button').hide();
   $('.details-container .new-comment textarea')
   .focus(function() {
      $('.details-container .new-comment button')
      .show()
      .click(function(e) {
         e.preventDefault();

         // insert new comment
         var task_id= $('.details-container h2').attr('item_id');

         $.post('index.php',{
            go:           'taskAddComment',
            task_id:      task_id, 
            text:          $('.details-container .new-comment textarea').val(),
         }, function(str) {
            updateDetailsContainerWithTask($('.details-container h2').attr('item_id'));
         });
      });
   });
}

function updateTaskIdInBrowserUrl(task_id)
{
   var currentUrl = $(location).attr('href');
   if ( currentUrl.search( /task=\d+/ ) == -1) {
      currentUrl += "&task="+task_id;
   }
   else{
      currentUrl = currentUrl.replace(/task=\d+/, "task="+task_id);
   }

   history.pushState(null, null, currentUrl);
}

function selectListEntry(elem)
{
   $('li.selected').removeClass('selected');
   $(elem).addClass('selected');

   var task_id= $(elem).data('id');
   updateTaskIdInBrowserUrl(task_id);

   updateDetailsContainerWithTask(task_id);

   // Scroll Item into view
   $("li.dragable.selected").scrollintoview( {
      duration: 200
   });

}

function updateListItemForTask(task_id)
{
   $.post('index.php',{
      go:           'taskBuildListEntryResponse',
      task_id:      task_id,      
   }, function(str) {
      var newLine = $(str);
      $('li#task-'+task_id).replaceWith(str);
      
      $('li#task-'+task_id).addClass('selected');
      makeListItemResortable($('li#task-'+task_id) );
   });

}
function updateDetailsContainerWithTask(task_id)
{
   $.post('index.php',{
     go: 'taskRenderDetailsViewResponse',
     tsk: task_id,
     from_handle: $('input#fromHandle').val(),
   }, function(str) {
      updateDetailsContainer(str);
   });   
}

function NewTaskLine(dom_element) 
{
   var _self = this;
   _self.dom_element= dom_element;
   _self.ol = $(_self.dom_element).parents('ol.sortable');
   
   $(_self.dom_element).click(function(e) 
   {
      _self.activateNewTaskLine();      
   });

   this.activateNewTaskLine= function()    
   {
      $(_self.ol).children('li.new-task-line').remove();            
      $(_self.ol).children('li.new-task-link').hide();

      _self.newTaskLine= $("<li class='new-task-line'>\
                     <input placeholder='Name'> \
                     <button>Add</button>\
                  </li>"); 

      _self.ol.prepend(_self.newTaskLine); // We have to append before setting focus...
      
      _self.newTaskLine
         .find('input')
         .focus()
         .keydown(function(e)
         {
            // Return
            if ( event.which == 13 ) {
                event.preventDefault();
                $(_self.newTaskLine).find('button').click();
            }
            // Esc
            else if ( event.which == 27) {
               $(_self.newTaskLine).remove();
               $(_self.ol).children('li.new-task-link').show();
            }
         });

      _self.newTaskLine
         .find('button')
         .click(function(e) {
            _self.sendNewTaskRequest(e);
         });      
   }

   this.sendNewTaskRequest = function(e)
   {
      e.preventDefault();

      var input= $(_self.ol).find('li.new-task-line input');

      if(!input.val()) {
         console.log("name can't be empty");
         return;
      }
      
      // insert new task
      $.post('index.php',{
         go:           'taskAjaxCreateNewTask',
         name:         input.val(),
         milestone_id: $(_self.ol).parent('div').data('milestone-id'),
         project_id:   $(_self.ol).parent('div').data('project-id'),
         order_id:     $(_self.newTaskLine).index(),
      }, function(str) {
         console.log(str);               

         var newLine = $(str);
         $(_self.ol).find('li.new-task-link').before( newLine);
         $(_self.newTaskLine).children('input').val('');
         selectListEntry(newLine);
         makeListItemResortable(newLine);
      });      
   }
}


function makeListItemResortable(item)
{
   //console.log("makeListItemResortable:",item, this);
   if($(item).is('li')) {
      $(item).click(function(e) 
      {
         selectListEntry(this);
         var task_id=  $(e.currentTarget).data('id')

         if(task_id)
            updateListItemForTask(task_id);
      });   
   }

   $(item).drag("start",function( ev, dd )
   {
      $(this)
         .css("opacity", 0.1);
      selectListEntry(this);
      return $( this ).clone()
         .css("opacity", .75 )
         .addClass("proxy")
         .appendTo( this.parentNode );
   
   })
   .drag(function( ev, dd ){
      var drop = dd.drop[0],
      method = $.data( drop || {}, "drop+reorder" );

      var position = $('div.page-content').position();
      var scrollOffsetY = $('div.page-content').scrollTop() - position.top;

      $( dd.proxy ).css({
         top: dd.offsetY + scrollOffsetY
      });
      
      if ( drop && ( drop != dd.current || method != dd.method ) ){   
         $( this )[ method ]( drop );
         dd.current = drop;
         dd.method = method;
         dd.update();
      }
   })
   .drag("end",function( ev, dd ){      
      var position = $('div.page-content').position();
      var scrollOffsetY = $('div.page-content').scrollTop() - position.top;

      var finalPosY=  $(this).position().top + $('div.page-content').scrollTop(); 
      var e = this;
      $( dd.proxy ).animate({
         top: finalPosY
      },{
         duration: 100,
         complete: function(){
            $(this).remove();
            $(e).css("opacity",1);
            var task_id=  $(e).data('id')

            if(task_id)
               updateListItemForTask(task_id);
         }            
      })
      $( this ).removeClass('dragging');

      $.post('index.php',{
         go: 'taskSetOrderId',
         task_id: $(e).data('id'),
         order_id: $(e).index(),
         milestone_id: $(e).parents('div.task-group').data('milestone-id'),
      }, 
      function(result) {
         console.log(result);
      });
   })
   .drop("init",function( ev, dd ){
      return !( this == dd.drag || this.tagName != dd.drag.tagName);
   });   
   $.drop({
      tolerance: function( event, proxy, target ){
         var test = event.pageY > ( target.top + target.height / 2 );
         $.data( target.elem, "drop+reorder", test ? "insertAfter" : "insertBefore" );   
         return this.contains( target, [ event.pageX, event.pageY ] );
      }
   });
}

jQuery(function($){
});

function selectTaskInUrl()
{
   var currentUrl = $(location).attr('href');
   if( currentUrl.search(/task=\d+/) !=-1) {
      var task_id = currentUrl.match(/task=(\d+)/)[1];
      $('li#task-'+task_id).each(function() {
         selectListEntry(this);   
      });      
   }
}

