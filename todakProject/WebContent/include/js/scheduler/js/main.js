var draggedEventIsAllDay;
var activeInactiveWeekends = true;
var editUser = $('#edit-username');

function holidayCount(){
	//console.log("holidayCount()");
	$.ajax({
	      type: "POST",
	      url: "/scheduler/selectHolidayCount.td",
	      data: {},
	      success: function (data) {
	    	console.log("--- "+" "+JSON.stringify(data));
	    	var empnum = data.empnum;
	    	var useResult = data.useResult;
	    	var regResult = data.regResult;
	    	var hoResult = data.hoResult;
	    	console.log(empnum);
	    	var holidaydata = "<thead><tr><td colspan='2'>"+ empnum +" 님의 총 휴가일수 15일 중"
	    		+"</td></tr></thead><tbody><tr><td>"
		    	+"등록 일수 </td><td>" + regResult +"일 </td></tr>"
		    	+"<tr><td>사용 일수"+ "</td><td>" + useResult +"일 </td></tr>"
		    	+"<tr><td>남은 등록 일수"+ "</td><td>" + hoResult + "일 </td></tr></tbody>";
		    
		    $('#holidayInfo').children().remove();
	    	$('#holidayInfo').append(holidaydata);
	    	
	      },
	      error : function(){
	    	  alert("휴가등록일수 fail");
	      }
	 });
}
function moveReference(){
	location.href="/human/reference.td";
}
function moveApptRecord(){
	location.href="/human/apptRecord.td";
}
function moveCommuteRecord(){
	location.href="/human/commuteRecord.td";
}


function getDisplayEventDate(event) {

  var displayEventDate;
  if (event.allDay == false) {
    var startTimeEventInfo = moment(event.start).format('HH:mm');
    var endTimeEventInfo = moment(event.end).format('HH:mm');
    displayEventDate = startTimeEventInfo + " - " + endTimeEventInfo;
  } else {
	console.log("else 진입");
    displayEventDate = "하루종일";
  }

  return displayEventDate;
}

function filtering(event) {
  var show_username = true;
  var show_type = true;

  var username = $('input:checkbox.filter:checked').map(function () {
    return $(this).val();
  }).get();
  var types = $('#type_filter').val();

  show_username = username.indexOf(event.username) >= 0;

  if (types && types.length > 0) {
    if (types[0] == "all") {
      show_type = true;
    } else {
      show_type = types.indexOf(event.type) >= 0;
    }
  }

  return true;
}

function calDateWhenResize(event) {

  var newDates = {
    startDate: '',
    endDate: ''
  };

  if (event.allDay) {
    newDates.startDate = moment(event.start._d).format('YYYY-MM-DD');
    newDates.endDate = moment(event.end._d).subtract(1, 'days').format('YYYY-MM-DD');
  } else {
    newDates.startDate = moment(event.start._d).format('YYYY-MM-DD HH:mm');
    newDates.endDate = moment(event.end._d).format('YYYY-MM-DD HH:mm');
  }

  return newDates;
}

function calDateWhenDragnDrop(event) {
  // 드랍시 수정된 날짜반영
  var newDates = {
    startDate: '',
    endDate: ''
  }

  // 하루짜리 all day
  if (event.allDay && event.end === true) {
    newDates.startDate = moment(event.start._d).format('YYYY-MM-DD');
    newDates.endDate = newDates.startDate;
  }

  // 2일이상 all day
  else if (event.allDay && event.end !== false) {
    newDates.startDate = moment(event.start._d).format('YYYY-MM-DD');
    newDates.endDate = moment(event.end._d).subtract(1, 'days').format('YYYY-MM-DD');
  }

  //all day가 아닐경우
  else if (!event.allDay) {
    newDates.startDate = moment(event.start._d).format('YYYY-MM-DD HH:mm');
    newDates.endDate = moment(event.end._d).format('YYYY-MM-DD HH:mm');
  }

  return newDates;
}

var calendar = $('#calendar').fullCalendar({
	
  eventRender: function (event, element, view) {
	  // 코드값 분류
	  var eventType = "";
	  var pEventType = event.type;
	  if(pEventType == 47){
		  eventType="연차"
	  }else if(pEventType == 48){
		  eventType="월차"
	  }else if(pEventType == 49){
		  eventType="반차"
	  }else if(pEventType == 50){
		  eventType="병가"
	  }else if(pEventType == 51){
		  eventType="정기휴가"
	  }else if(pEventType == 56){
		  eventType="회의"
	  }else if(pEventType == 57){
		  eventType="미팅"
	  }
	  
    // 일정에 hover시 요약
    element.popover({
      title: $('<div />', {
        class: 'popoverTitleCalendar',
        text: event.title
      }).css({
        'background': event.backgroundColor,
        'color': event.textColor
      }),
      content: $('<div />', {
          class: 'popoverInfoCalendar'
        }).append('<p><strong>등록자:</strong> ' + event.username + '</p>')
        .append('<p><strong>구분:</strong> ' + eventType + '</p>')
        .append('<p><strong>시간:</strong> ' + getDisplayEventDate(event) + '</p>')
        .append('<div class="popoverDescCalendar"><strong>설명:</strong> ' + event.description + '</div>'),
      delay: {
        show: "800",
        hide: "50"
      },
      trigger: 'hover',
      placement: 'top',
      html: true,
      container: 'body'
    });

    return filtering(event);

  },

  // 주말 보이기 & 숨기기 버튼
  customButtons: {
    viewWeekends: {
      text: '주말',
      click: function () {
        activeInactiveWeekends ? activeInactiveWeekends = false : activeInactiveWeekends = true;
        $('#calendar').fullCalendar('option', {
          weekends: activeInactiveWeekends
        });
      }
    }
  },

  header: {
    left: 'today, prevYear, nextYear, viewWeekends',
    center: 'prev, title, next',
    right: 'month,agendaWeek,agendaDay,listWeek'
  },
  views: {
    month: {
      columnFormat: 'dddd'
    },
    agendaWeek: {
      columnFormat: 'M/D ddd',
      titleFormat: 'YYYY년 M월 D일',
      eventLimit: false
    },
    agendaDay: {
      columnFormat: 'dddd',
      eventLimit: false
    },
    listWeek: {
      columnFormat: ''
    }
  },

  /* ****************
   *  일정 받아옴
   * ************** */
 events: function (start, end, timezone, callback) {
	 var eventData = {
	            username: editUser.val(),	 
	        };
//	  var username = $('#edit-username');
//	  var realuser = username.val();
//	  console.log("realuser : >>>>>>>>>>>>>>> " + JSON.stringify(realuser));
	 console.log("사원번호 :"+" "+eventData.username);
	    $.ajax({
	      type: "POST",
	      url: "/scheduler/selectSchedule.td",
//          contentType: "application/x-www-form-uriencoded; charset=euc-kr",
	      data: {
	    	  hm_empnum : eventData.username 
	        // 실제 사용시 날짜를 전달해 일정기간 데이터만 받아오기
	      },
	      success: function (response) {
	        var fixedDate = response.map(function(array) {
	        	//console.log("1212121221" + " ----" + array._id);
	        	var result = eval(array.allDay);
	        	console.log("result >>>>> : " + result);
	          if (result) { 
	        	  if(array.end != array.start){
	        		  console.log("array.end != array.start >>> : " + array.end != array.start);
	        		 array.end = moment(array.end).add(1,'days').format('YYYY-MM-DD');
	        		 console.log("result 트루이고 다음 if도 트루 >> " +array.start+"~"+ array.end)
		          }else{
		        	  console.log("if(array.end != array.start)-else 진입 ");
		        	// 이틀 이상 AllDay 일정인 경우 달력에 표기시 하루를 더해야 정상 출력
		        	array.end = moment(array.end).add(1,'days').format('YYYY-MM-DD');
		          }   	  
	          }
	          else{
	        	  console.log("if (result)-else 진입 ");
	        	  array.end = moment(array.end).format('YYYY-MM-DD HH:mm');
	          }
	          return array;
	        })
	        callback(fixedDate);
	        
	      },
	      error : function(){
	    	  alert("제대로 일정 받아오기 실패");
	      }
	    });
	  },

  eventAfterAllRender: function (view) {
    if (view.name == "month") {
      $(".fc-content").css('height', 'auto');
    }
  },

  // 일정 리사이즈
  eventResize: function (event, delta, revertFunc, jsEvent, ui, view) {
    $('.popover.fade.top').remove();

    /** 리사이즈시 수정된 날짜 반영
     *  하루를 빼야 정상적으로 반영됨 */
    var newDates = calDateWhenResize(event);
    var realEndDay = moment(event.end).subtract(1,'days').format('YYYY-MM-DD');
    // 리사이즈한 일정 업데이트
    $.ajax({
      type: "POST",
      url: "/scheduler/updateSchedule.td",
//      contentType: "application/json; charset=euc-kr",
      data: {
    	sw_num : event.num,
    	hm_empnum : event.username,
    	sw_title: event.title,
      	sw_startdate: event.start,
      	sw_enddate: realEndDay,
      	sw_content: event.description,
      	sw_type: event.type,
      	sw_backgroundcolor:event.backgroundColor,
      	sw_repetitiontype: event.allDay
        //id: event._id,
        //....
      },
      success: function (response) {
    	  console.log('수정: ' + newDates.startDate + ' ~ ' + newDates.endDate);
      }
    });

  },

  eventDragStart: function (event, jsEvent, ui, view) {
    draggedEventIsAllDay = event.allDay;
  },

  // 일정 드래그앤 드롭
  eventDrop: function (event, delta, revertFunc, jsEvent, ui, view) {
    $('.popover.fade.top').remove();

    // 주 , 일 view일때 종일 <-> 시간 변경 불가
    if (view.type === 'agendaWeek' || view.type === 'agendaDay') {
      if (draggedEventIsAllDay !== event.allDay) {
        alert('드래그앤드롭으로 종일 <-> 시간 변경은 불가합니다.');
        location.reload();
        return false;
      }
    }

    // 드랍시 수정된 날짜 반영
    var newDates = calDateWhenDragnDrop(event);
    
    // 업데이트시 date 형태 moment.js 에서 format 맞춰야해 
    event.start = moment(event.start).format('YYYY-MM-DD');
    event.end = moment(event.end).subtract(1,'days').format('YYYY-MM-DD');
    
    // 드롭한 일정 업데이트
    $.ajax({
      type: "POST",
      url: "/scheduler/updateSchedule.td",
//      contentType: "application/json; charset=euc-kr",
      data: {
    	  	sw_num : event._id,
    	  	hm_empnum : event.username,
        	sw_title: event.title,
        	sw_startdate: event.start,
        	sw_enddate: event.end,
        	sw_content: event.description,
        	sw_type: event.type,
        	sw_backgroundcolor:event.backgroundColor,
        	sw_repetitiontype: event.allDay
        //...
      },
      success: function (response) {
        alert('수정: ' + newDates.startDate + ' ~ ' + newDates.endDate);
        
      },
      error : function(response){
    	  console.log("[드래그앤드롭] >>> : " + JSON.stringify(response));
    	  console.log("[드래그앤드롭] Ajax 연결실패 ");
      }
    });

  },

  select: function (startDate, endDate, jsEvent, view) {

    $(".fc-body").unbind('click');
    $(".fc-body").on('click', 'td', function (e) {

      $("#contextMenu")
        .addClass("contextOpened")
        .css({
          display: "block",
          left: e.pageX,
          top: e.pageY
        });
      return false;
    });

    var today = moment();

    if (view.name == "month") {
      startDate.set({
        hours: today.hours(),
        minute: today.minutes()
      });
      startDate = moment(startDate).format('YYYY-MM-DD HH:mm');
      endDate = moment(endDate).subtract(1, 'days');

      endDate.set({
        hours: today.hours() + 1,
        minute: today.minutes()
      });
      endDate = moment(endDate).format('YYYY-MM-DD HH:mm');
    } else {
      startDate = moment(startDate).format('YYYY-MM-DD HH:mm');
      endDate = moment(endDate).format('YYYY-MM-DD HH:mm');
    }

    // 날짜 클릭시 카테고리 선택메뉴
    var $contextMenu = $("#contextMenu");
    $contextMenu.on("click", "a", function (e) {
      e.preventDefault();

      // 닫기 버튼이 아닐때 
      if ($(this).data().role !== 'close') {
        newEvent(startDate, endDate, $(this).html());
      }

      $contextMenu.removeClass("contextOpened");
      $contextMenu.hide();
    });

    $('body').on('click', function () {
      $contextMenu.removeClass("contextOpened");
      $contextMenu.hide();
    });
    
  },

  // 이벤트 클릭시 수정 이벤트
  eventClick: function (event, jsEvent, view) {
    editEvent(event);
  },

  locale: 'ko',
  timezone: "local",
  nextDayThreshold: "09:00:00",
  allDaySlot: true,
  displayEventTime: true,
  displayEventEnd: true,
  firstDay: 0, // 월요일 먼저 오게 하려면 1
  weekNumbers: false,
  selectable: true,
  weekNumberCalculation: "ISO",
  eventLimit: true,
  views: {
    month: {
      eventLimit: 12
    }
  },
  eventLimitClick: 'week', //popover
  navLinks: true,
  //defaultDate: moment('2019-05'), // 실제 사용시 삭제
  timeFormat: 'HH:mm',
  defaultTimedEventDuration: '01:00:00',
  editable: true,
  minTime: '00:00:00',
  maxTime: '24:00:00',
  slotLabelFormat: 'HH:mm',
  weekends: true,
  nowIndicator: true,
  dayPopoverFormat: 'MM/DD dddd',
  longPressDelay: 0,
  eventLongPressDelay: 0,
  selectLongPressDelay: 0
});