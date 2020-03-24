var eventModal = $('#eventModal');
var eventId = $('#edit-num');
var modalTitle = $('.modal-title');
// 새로 추가한거
var editAllDay = $('#edit-allDay');
var editUser = $('#edit-username');
var editTitle = $('#edit-title');
var editStart = $('#edit-start');
var editEnd = $('#edit-end');
var editType = $('#edit-type');
var editColor = $('#edit-color');
var editDesc = $('#edit-desc');

var addBtnContainer = $('.modalBtnContainer-addEvent');
var modifyBtnContainer = $('.modalBtnContainer-modifyEvent');


/* ****************
 *  새로운 일정 생성
 * ************** */
var newEvent = function (start, end, eventType) {

    $("#contextMenu").hide(); // 메뉴 숨김

    modalTitle.html('새로운 일정');
    editStart.val(start);
    editEnd.val(end);
    editTitle.val('');
    editDesc.val('');
    editType.val(eventType).prop("selected", true);

    addBtnContainer.show();
    modifyBtnContainer.hide();
    eventModal.modal('show');

    // 새로운 일정 저장버튼 클릭
    $('#save-event').unbind();
    $('#save-event').on('click', function () {

        var eventData = {
            _id: eventId.val(),
            title: editTitle.val(),
            start: editStart.val(),
            end: editEnd.val(),
            description: editDesc.val(),
            type: editType.val(),
            username: editUser.val(),
            backgroundColor: editColor.val(),
            textColor: '#ffffff',
            allDay: editAllDay.val()
        };

        if (eventData.start > eventData.end) {
            alert('끝나는 날짜가 앞설 수 없습니다.');
            return false;
        }

        if (eventData.title === '') {
            alert('일정명은 필수입니다.');
            return false;
        }

        var realEndDay;
        console.log("--- + " + editAllDay.is(':checked'));
        if (editAllDay.is(':checked')) {
            eventData.start = moment(eventData.start).format('YYYY-MM-DD');
            //render시 날짜표기 수정
            eventData.end = moment(eventData.end).add(1,'days').format('YYYY-MM-DD');
            // DB에 넣을때(선택)
            realEndDay = moment(eventData.end).subtract(1,'days').format('YYYY-MM-DD');

            eventData.allDay = true;
        }else{
        	console.log("if - else + " + editAllDay.is(':checked'));
        	 realEndDay = moment(eventData.end).format('YYYY-MM-DD HH:mm'); 
        }
        
        $("#calendar").fullCalendar('renderEvent', eventData, true);
        eventModal.find('input, textarea').val('');
        editAllDay.prop('checked', false);
        eventModal.modal('hide');
        
        // 새로운 일정 저장
        $.ajax({
            type: "POST",
            url: "/scheduler/insertSchedule.td",        
            data :{
            	sw_num: eventData._id,
            	sw_title: eventData.title,
            	sw_startdate: eventData.start,
            	sw_enddate: realEndDay,
            	sw_content: eventData.description,
            	sw_type: eventData.type,
            	hm_empnum: eventData.username,
            	sw_backgroundcolor:eventData.backgroundColor,
            	sw_textcolor: eventData.textColor,
            	sw_repetitiontype: eventData.allDay
            },
            success: function (response) {          
            	console.log("Ajax 연결 성공");
                //DB연동시 중복이벤트 방지를 위한
                $('#calendar').fullCalendar('removeEvents');
                $('#calendar').fullCalendar('refetchEvents');
            },
            error : function(response){
            	console.log("[INSERT] Ajax 연결 실패");
            }
        });
    });
};