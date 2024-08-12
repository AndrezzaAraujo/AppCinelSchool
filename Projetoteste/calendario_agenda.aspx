<%@ Page Title="" Language="C#" MasterPageFile="~/intranet.Master" AutoEventWireup="true" CodeBehind="calendario_agenda.aspx.cs" Inherits="Projetoteste.calendario_agenda" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js'></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

    <style>
        .modal-dialog {
            margin: 0;
            top: 100px;
        }
        .fc-event {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 5px;
            background-color: #f0f0f0; 
            color: #333; 
            border: 1px solid #ccc; 
            border-radius: 5px; 
            cursor: pointer;
        }
        .fc-event:hover {
            background-color: #e0e0e0; 
        }
        .fc-event i {
            margin-left: 5px;
        }
        .fa-trash {
            color: red;
        }
    </style>

        <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js'></script>
        <script>
            $(document).ready(function () {
                carregarEventos();
            });

            function carregarEventos() {
                $.ajax({
                    url: 'calendario_agenda.aspx/carregarEventosIndisponiveis',
                    method: 'POST',
                    contentType: "application/json",
                    dataType: "json",
                    success: function (response) {
                        initializeCalendar(response.d);
                    },
                    error: function () {
                        alert("Erro ao carregar eventos indisponíveis");
                    }
                });
            }

            function initializeCalendar(eventos) {
                var calendarEl = document.getElementById('calendar');
                var calendar = new FullCalendar.Calendar(calendarEl, {
                    headerToolbar: {
                        left: 'prev,next today',
                        center: 'title',
                        right: 'dayGridMonth,timeGridWeek,timeGridDay'
                    },
                    initialView: 'dayGridMonth',
                    events: eventos,
                    dateClick: function (info) {
                        $('#modal').modal('show');
                        $('#selectedDate').val(info.dateStr);
                    },
                    eventContent: function (arg) {
                        const eventTitle = arg.event.title;
                        return { html: `<div>${eventTitle} <i class="fa fa-trash" onclick="excluirEvento(${arg.event.id})"></i></div>` };
                    }
                });
                calendar.render();
            }

            function excluirEvento(eventId) {
                if (confirm("Tem certeza que deseja excluir este evento?")) {
                    $.ajax({
                        url: 'calendario_agenda.aspx/excluirEvento',
                        method: 'POST',
                        contentType: "application/json",
                        data: JSON.stringify({ eventId: eventId }),
                        dataType: "json",
                        success: function (response) {
                            if (response.d === "Sucesso") {
                                alert("Evento excluído com sucesso!");
                                carregarEventos();
                            } else {
                                alert("Erro ao excluir evento");
                            }
                        },
                        error: function () {
                            alert("Erro de conexão");
                        }
                    });
                }
            }

            function bloquearIntervalo() {
                var selectedDate = $('#selectedDate').val();
                var startTime = $('#startTime').val();
                var endTime = $('#endTime').val();

                $.ajax({
                    url: 'calendario_agenda.aspx/bloquearDia',
                    method: 'POST',
                    contentType: "application/json",
                    data: JSON.stringify({ selectedDate: selectedDate, startTime: startTime, endTime: endTime }),
                    dataType: "json",
                    success: function (response) {
                        if (response.d === "Sucesso") {
                            $('#modal').modal('hide');
                            alert("Dias bloqueados com sucesso!");
                            carregarEventos();
                        } else {
                            alert(response.d);
                        }
                    },
                    error: function () {
                        alert("Erro de conexão");
                    }
                });
            }

            //document.addEventListener('DOMContentLoaded', function () {
            //    var calendarEl = document.getElementById('calendar');
            //    var calendar = new FullCalendar.Calendar(calendarEl, {

            //        headerToolbar: {
            //            left: 'prev,next today',
            //            center: 'title',
            //            right: 'dayGridMonth,timeGridWeek,timeGridDay'
            //        },
            //        initialView: 'dayGridMonth',
            //        dateClick: function (info) {
            //            if (confirm("Gostaria de deixar esse dia como indisponível ?")) {
            //                console.log(info);
            //                bloquearDia();
            //            }                       
            //        }
            //    });
            //    calendar.render();
            //});

            //function bloquearDia() {
            //    // Send the new event data to the server using Ajax
            //    $.ajax({
            //        url: 'calendario_agenda.aspx/bloquearDia', // Replace with the actual server endpoint
            //        method: 'POST',
            //        contentType: "application/json",

            //        dataType: "json",
            //        success: function (response) {
            //            console.log(response)
            //            if (response == "success") {
            //                // Event saved successfully


            //            } else {
            //                // Handle error response
            //                // Display error message, etc.
            //            }
            //        },
            //        error: function () {
            //            // Handle Ajax error
            //            // Display error message, etc.
            //        }
            //    });
            //}
        </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <body>
        <div style="margin: 10rem;">
            <div id='calendar' style="width: 100%; height: 100%"></div>
        </div>

        <div class="modal fade" id="modal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalLabel">Selecione o intervalo de tempo</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="startTime">Hora de início:</label>
                            <input type="time" class="form-control" id="startTime">
                        </div>
                        <div class="form-group">
                            <label for="endTime">Hora de término:</label>
                            <input type="time" class="form-control" id="endTime">
                        </div>
                        <input type="hidden" id="selectedDate" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                        <button type="button" class="btn btn-primary" onclick="bloquearIntervalo()">Confirmar</button>
                    </div>
                </div>
            </div>
        </div>
    </body>
      
</asp:Content>
