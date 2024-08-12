<%@ Page Title="" Language="C#" MasterPageFile="~/intranet.Master" AutoEventWireup="true" CodeBehind="calendario.aspx.cs" Inherits="Projetoteste.calendario" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js'></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
<style>
.main {
    padding: 60px 30px 0px 30px;
}

.row {
    display: flex;
    flex-wrap: wrap;
    margin-right: -15px;
    margin-left: -15px;
}

.col {
    flex: 1 0 0%;
}

.form-group {
    margin-bottom: 1rem;
}

.form-control, select {
    display: block;
    width: 100%;
    padding: .375rem .75rem;
    font-size: 1rem;
    line-height: 1.5;
    color: #495057;
    background-color: #fff;
    background-clip: padding-box;
    border: 1px solid #ced4da;
    border-radius: .25rem;
}

label {
    display: inline-block;
    margin-bottom: .5rem;
}

.event-tag {
    background-color: #007BFF; /* Azul */
    color: white;
    padding: 5px 10px;
    border-radius: 5px;
    font-size: 0.85em;
    display: inline-block;
    margin: 2px;
    display: flex;
    flex-direction: column;
    width: 100%;
}

.event-time {
    background-color: #FFC107; /* Amarelo */
    border-radius: 4px;
    padding: 2px 6px;
    margin-right: 5px;
}

.event-name {
    font-weight: bold;
}

.fc-event { /* Classe padrão do FullCalendar para eventos */
    overflow: hidden; /* Esconde qualquer conteúdo que exceda o tamanho do contêiner */
    white-space: nowrap; /* Evita que o texto quebre em linhas */
    text-overflow: ellipsis; /* Adiciona reticências se o texto for maior que o contêiner */
}

.fc-daygrid-day-frame {
    height: 100% !important;
    overflow-y: auto !important;
}

.fc-day {
    overflow-y: auto !important;
    height: 231px !important;
}
</style>
    <link href="Content/bootstrap.css" rel="stylesheet" />

    <script src="Scripts/bootstrap.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        $(document).ready(function () {
            carregarTurma();

            $('#<%= turmaDropdown.ClientID %>').change(function () {
                carregarCalendario();
            });
        });

        function carregarTurma() {
            $.ajax({
                url: 'calendario.aspx/carregarTurma',
                method: 'POST',
                contentType: "application/json",
                dataType: "json",
                success: function (response) {
                    console.log(response);
                    var ddlModulo = $('#<%= turmaDropdown.ClientID %>');

                    ddlModulo.empty();

                    var items = JSON.parse(response.d || "[]");

                    if (items.length) {
                        items.forEach(function (item) {
                            var option = $("<option></option>").val(item.Value).html(item.Text);
                            ddlModulo.append(option);
                        });
                    }
                },
                error: function () {
                    alert("Erro ao carregar eventos indisponíveis");
                }
            });
        }

        function carregarCalendario() {
            var turmaId = $('#<%= turmaDropdown.ClientID %>').val();
            $.ajax({
                type: "POST",
                url: '<%= ResolveUrl("calendario.aspx/CarregarCalendario") %>',
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({ codTurma: turmaId }),
                success: function (response) {
                    initializeCalendar(response);
                },
                error: function (xhr, status, error) {
                    console.error("Erro ao carregar eventos:", error);
                }
            });
        }

        function initializeCalendar(eventosData) {
            var eventos = JSON.parse(eventosData.d);
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
                    carregarDisponibilidades(info.dateStr, $('#<%= turmaDropdown.ClientID %>').val());
                },
                eventContent: function (arg) {
                    var startTime = new Date(arg.event.start);
                    var endTime = new Date(arg.event.end);

                    var startTimeStr = startTime.getHours().toString().padStart(2, '0') + ':' + startTime.getMinutes().toString().padStart(2, '0');
                    var endTimeStr = endTime.getHours().toString().padStart(2, '0') + ':' + endTime.getMinutes().toString().padStart(2, '0');

                    return {
                        html: `<div class='event-tag'>
                         <span class='event-time'>${startTimeStr} - ${endTimeStr}</span>
                         <span class='event-details'>Professor: ${arg.event.extendedProps.professor}</span>
                         <span class='event-details'>Turma: ${arg.event.extendedProps.turma}</span>
                         <span class='event-details'>Sala: ${arg.event.extendedProps.sala}</span>
                         <span class='event-details'>Módulo: ${arg.event.extendedProps.modulo}</span>
                       </div>`
                    };
                }
            });
            calendar.render();
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="main">
        <div class="row" style="margin: 1rem;">
            <div class="col">
                <div class="form-group">
                    <label for="professorDropdown">Turma:</label>
                    <asp:DropDownList ID="turmaDropdown" runat="server" CssClass="form-control">
                    </asp:DropDownList>
                </div>
            </div>
        </div>
    </div>

    <div style="padding: 0px 40px;">
        <div id='calendar' style="width: 100%; height: 100%; margin-top: 20px; margin-bottom: 20px"></div>
    </div>
</asp:Content>
