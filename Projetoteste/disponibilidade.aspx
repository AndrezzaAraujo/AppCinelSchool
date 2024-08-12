<%@ Page Title="" Language="C#" MasterPageFile="~/intranet.Master" AutoEventWireup="true" CodeBehind="disponibilidade.aspx.cs" Inherits="Projetoteste.disponibilidade" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%--<script>
        import { Calendar } from '@fullcalendar/core';
        import dayGridPlugin from '@fullcalendar/daygrid';
        import timeGridPlugin from '@fullcalendar/timegrid';
        import listPlugin from '@fullcalendar/list';

        let calendarEl = document.getElementById('calendar');
        let calendar = new Calendar(calendarEl, {
            plugins: [dayGridPlugin, timeGridPlugin, listPlugin],
            initialView: 'dayGridMonth',
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'dayGridMonth,timeGridWeek,listWeek'
            }
        });
        calendar.render();
    </script>--%>
    <%--Indian video--%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/fullcalendar.min.css" rel="stylesheet" />
    <script src='http://fullcalendar.io/js/fullcalendar-2.1.1/lib/moment.min.js'></script>
    <script src='http://fullcalendar.io/js/fullcalendar-2.1.1/lib/jquery.min.js'></script>
    <script src="http://fullcalendar.io/js/fullcalendar-2.1.1/lib/jquery-ui.custom.min.js"></script>
    <script src='http://fullcalendar.io/js/fullcalendar-2.1.1/fullcalendar.min.js'></script>
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <script src="Scripts/bootstrap.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <%--/Indian video--%>

   <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js'></script>
    <script>

        document.addEventListener('DOMContentLoaded', function () {
            var calendarEl = document.getElementById('calendar');
            var calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth'
                
            });
            calendar.render();
        });

    </script>
<style>
    #calendar{
        /*margin: 70px 20px 0 20px;*/
        /*margin-top: 80px;*/
        max-width: 1100px;
        margin: 60px auto;
    }

</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">   

    <section class="content" style="background-color:white">
        <div class="row">
            <div class="col-xs-12">
                <div id="calendar" style="width: 1200px; margin-left: 105px;">
                </div>
            </div>

        </div>
    </section>
<!-- Add Event Modal -->
<div class="modal fade" id="addEventModal" tabindex="-1" role="dialog" aria-labelledby="addEventModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addEventModalLabel">Add Event</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div  id="frm">
                  
                    <div class="form-group">
                        <label for="eventStartDate">Start Date</label>
                        <input type="date" class="form-control" id="eventStartDate" name="startDate" required>
                    </div>
                    <div class="form-group">
                        <label for="eventStartTime">Start Time</label>
                        <input type="time" class="form-control" id="eventStartTime" name="startTime" required>
                    </div>
                    <div class="form-group">
                        <label for="eventEndTime">End Time</label>
                        <input type="time" class="form-control" id="eventEndTime" name="endTime" required>
                    </div>
                    <!-- Other event fields... -->
                    <button type="button" id="addEventForm" class="btn btn-primary">Add Event</button>
                </div>
            </div>
        </div>
    </div>
</div>
    
    <script>
        $(document).ready(function () {
            $(document).ready(function () {
                InitializeCalendar();
            });
            function InitializeCalendar() {

                $.ajax({
                    type: "POST",
                    contentType: "application/json",
                    url: "/Disponibilidade.aspx/GetCalendarData",
                    dataType: "json",
                    success: function (data) {


                        $('#calendar').empty();
                        $('#calendar').fullCalendar({
                            header: {
                                left: 'prev,next today',
                                center: 'title',
                                right: 'month,agendaWeek,agendaDay'
                            },
                            //weekNumbers: true,
                            height: 600,
                            width: 100,
                            allDayText: 'Events',
                            selectable: true,
                            overflow: 'auto',
                            editable: true,
                            firstDay: 1,
                            slotEventOverlap: true,
                            dayClick: function (date, jsEvent, view) {
                                // Show a modal or form to add a new event
                                $('#addEventModal').modal('show'); // Assuming you have a modal with the ID 'addEventModal'
                                $('#eventStartDate').val(date.format()); // Pre-fill the selected date in the form
                            },
                            events: $.map(data.d, function (item, i) {

                                //-- here is the event details to show in calendar view.. the data is retrieved via ajax call will be accessed here
                                var eventStartDate = new Date(parseInt(item.slotStartTime.substr(6)));
                                var eventEndDate = new Date(parseInt(item.slotEndTime.substr(6)));

                                var event = new Object();
                                event.id = item.slotID;
                                //event.start = new Date(eventStartDate.getFullYear(), eventStartDate.getMonth(), eventStartDate.getDate(), eventStartDate.getHours(), 0, 0, 0);
                                //event.end = new Date(eventEndDate.getFullYear(), eventEndDate.getMonth(), eventEndDate.getDate(), eventEndDate.getHours() + 1, 0, 0, 0);
                                event.start = eventStartDate;
                                //  event.end = eventEndDate;

                                event.title = formatAMPM(eventStartDate) + "-" + formatAMPM(eventEndDate);
                                //event.allDay = item.AllDayEvent;
                                event.backgroundColor = item.color;
                                event.allDay = true;
                                return event;
                            })
                        });
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        //-- log error
                    }
                });
            }

            $('#addEventForm').on('click', function (e) {
                debugger;

                var formData = $('#frm').serializeArray();
                var newEvent = {
                    slotDate: new Date($('#eventStartDate').val()),
                    slotStartTime: $('#eventStartDate').val() + ' ' + $('#eventStartTime').val(),
                    slotEndTime: $('#eventStartDate').val() + ' ' + $('#eventEndTime').val(),
                    // Other event properties...
                };

                // Send the new event data to the server using Ajax
                $.ajax({
                    url: 'Default.aspx/SaveEvent', // Replace with the actual server endpoint
                    method: 'POST',
                    data: JSON.stringify({ newEvent: newEvent }),
                    contentType: "application/json",

                    dataType: "json",
                    success: function (response) {
                        if (response.d == "success") {
                            // Event saved successfully

                            $('#calendar').fullCalendar('destroy');

                            $('#addEventModal').modal('hide');
                            $('#eventStartDate').val('');
                            $('#eventStartTime').val('');
                            $('#eventEndTime').val('');
                            InitializeCalendar();
                        } else {
                            // Handle error response
                            // Display error message, etc.
                        }
                    },
                    error: function () {
                        // Handle Ajax error
                        // Display error message, etc.
                    }
                });
            });

        })
        function formatAMPM(date) {
            var hours = date.getHours();
            var minutes = date.getMinutes();
            var ampm = hours >= 12 ? 'pm' : 'am';
            hours = hours % 12;
            hours = hours ? hours : 12; // the hour '0' should be '12'
            minutes = minutes < 10 ? '0' + minutes : minutes;
            var strTime = hours + ':' + minutes + ' ' + ampm;
            return strTime;
        }
    </script>

     <%--<div  id='calendar'></div> <%-- /daygrid Docs / months view--%>
    <%--  <script>
        import { Calendar } from '@fullcalendar/core'
        import dayGridPlugin from '@fullcalendar/daygrid'

        const calendar = new Calendar(calendarEl, {
            plugins: [dayGridPlugin],
            initialView: 'dayGridYear'            
        })

        var calendar = new Calendar(calendarEl, {
            titleFormat: { // will produce something like "Tuesday, September 18, 2018"
                month: 'long',
                year: 'numeric',
                day: 'numeric',
                weekday: 'long'
            }
        })
    </script>--%>
</asp:Content>
