<%@ Page Title="" Language="C#" MasterPageFile="~/intranet.Master" AutoEventWireup="true" CodeBehind="marcacao_aulas.aspx.cs" Inherits="Projetoteste.marcacao_aulas" %>

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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#<%= turmaDropdown.ClientID %>').change(function () {
                updateModulos();
            });

            $('#<%= professorDropdown.ClientID %>').change(function () {
                carregarCalendario();
            });

        });

        function validateTime() {
            var startTime = $('#startTime').val();
            var endTime = $('#endTime').val();
            var dateSelected = $('#selectedDate').val();
            var professorId = $('#<%= professorDropdown.ClientID %>').val();

            if (!startTime || !endTime || startTime >= endTime) {
                alert("Por favor, selecione horários válidos.");
                return;
            }

            $.ajax({
                type: "POST",
                url: '<%= ResolveUrl("marcacao_aulas.aspx/CarregarEventosDatasIndispolivel") %>',
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({ codProfessor: professorId, data: dateSelected }),
                dataType: "json",
                success: function (res) {
                    var unavailable = res.d;
                    var isAvailable = true;

                    unavailable.forEach(function (period) {
                        const unavailableStart = period.Start.substring(11, 16);
                        const unavailableEnd = period.End.substring(11, 16);
                        if ((startTime < unavailableEnd && startTime >= unavailableStart) ||
                            (endTime > unavailableStart && endTime <= unavailableEnd) ||
                            (startTime < unavailableStart && endTime > unavailableEnd)) {
                            isAvailable = false;
                        }
                    });

                    if (!isAvailable) {
                        alert("Os horários selecionados estão em conflito com períodos indisponíveis.");
                    } else {
                        // Continue com a lógica para confirmar o agendamento
                        alert("Horário válido. Continuar com a operação.");
                    }
                },
                error: function (xhr, status, error) {
                    console.error("Erro ao verificar disponibilidade:", error);
                }
            });
        }

        function updateModulos() {
            var turmaId = $('#<%= turmaDropdown.ClientID %>').val();
            $.ajax({
                type: "POST",
                url: '<%= ResolveUrl("marcacao_aulas.aspx/GetModulos") %>',
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({ codTurma: turmaId }),
                dataType: "json",
                success: function (response) {
                    console.log(response);
                    var ddlModulo = $('#<%= moduloDropdown.ClientID %>');

                    ddlModulo.empty();

                    var items = JSON.parse(response.d || "[]");

                    if (items.length) {
                        items.forEach(function (item) {
                            var option = $("<option></option>").val(item.Value).html(item.Text);
                            ddlModulo.append(option);
                        });
                    }
                },
                error: function (xhr, status, error) {
                    console.error("Erro ao carregar módulos:", error);
                }
            });
        }

        function carregarCalendario() {
            var professorId = $('#<%= professorDropdown.ClientID %>').val();
            $.ajax({
                type: "POST",
                url: '<%= ResolveUrl("marcacao_aulas.aspx/CarregarCalendario") %>',
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({ codProfessor: professorId }),
                success: function (response) {
                    initializeCalendar(response);
                    $('#modal').modal('hide');
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
                    carregarDisponibilidades(info.dateStr, $('#<%= professorDropdown.ClientID %>').val());
                },
                eventContent: function (arg) {
                    var startTime = new Date(arg.event.start);
                    var endTime = new Date(arg.event.end);

                    var startTimeStr = startTime.getHours().toString().padStart(2, '0') + ':' + startTime.getMinutes().toString().padStart(2, '0');
                    var endTimeStr = endTime.getHours().toString().padStart(2, '0') + ':' + endTime.getMinutes().toString().padStart(2, '0');

                    return {
                        html: `<div class='event-tag'>
                 <span class='event-time'>${startTimeStr} - ${endTimeStr}</span>
                 <span class='event-details'>Turma: ${arg.event.extendedProps.turma}</span>
                 <span class='event-details'>Sala: ${arg.event.extendedProps.sala}</span>
                 <span class='event-details'>Módulo: ${arg.event.extendedProps.modulo}</span>
                </div>`
                    };
                }
            });
            calendar.render();
        }

        function carregarDisponibilidades(dataSelecionada, professorId) {
            $.ajax({
                type: "POST",
                url: '<%= ResolveUrl("marcacao_aulas.aspx/CarregarEventosDatasIndispolivel") %>',
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({ codProfessor: professorId, data: dataSelecionada }),
                dataType: "json",
                success: function (res) {
                    var datasIndisponivel = res.d;
                    var indisponivelList = $('#indisponivelList');
                    indisponivelList.empty();
                    datasIndisponivel.forEach(function (horario) {

                        var timeRange = `<tr><td>${horario.Start}</td><td>${horario.End}</td></tr>`;
                        indisponivelList.append($(timeRange));
                    });
                },
                error: function (xhr, status, error) {
                    console.error("Erro ao carregar horários disponíveis:", error);
                }
            });
        }

        function confirmarMarcacao() {
            var codUser = $('#<%= professorDropdown.ClientID %>').val();
            var codTurma = $('#<%= turmaDropdown.ClientID %>').val();
            var codSala = $('#<%= salaDropdown.ClientID %>').val();
            var codModulo = $('#<%= moduloDropdown.ClientID %>').val();
            var dataInicio = $('#selectedDate').val() + 'T' + $('#startTime').val();
            var dataFim = $('#selectedDate').val() + 'T' + $('#endTime').val();

            // Verificação de cada campo com mensagens específicas
            if (!codUser || codUser === "0") {
                alert("Por favor, selecione um formador.");
                return;
            }
            if (!codTurma || codTurma === "0") {
                alert("Por favor, selecione uma turma.");
                return;
            }
            if (!codSala || codSala === "0") {
                alert("Por favor, selecione uma sala.");
                return;
            }
            if (!codModulo || codModulo === "0") {
                alert("Por favor, selecione um módulo.");
                return;
            }
            if (!$('#selectedDate').val()) {
                alert("Por favor, selecione uma data.");
                return;
            }
            if (!$('#startTime').val()) {
                alert("Por favor, selecione a hora de início.");
                return;
            }
            if (!$('#endTime').val()) {
                alert("Por favor, selecione a hora de término.");
                return;
            }

            // Proceder com a lógica para confirmar o agendamento
            $.ajax({
                type: "POST",
                url: '<%= ResolveUrl("marcacao_aulas.aspx/SalvarMarcacaoAula") %>',
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({ codUser: codUser, codTurma: codTurma, codSala: codSala, codModulo: codModulo, dataInicio: dataInicio, dataFim: dataFim }),
                dataType: "json",
                success: function (response) {
                    alert(response.d);
                    carregarCalendario();
                },
                error: function (xhr, status, error) {
                    console.error("Erro ao salvar marcação: ", error);
                }
            });
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="main">
        <div class="row" style="gap: 1rem;">
            <div class="col">
                <div class="form-group">
                    <label for="professorDropdown">Formador:</label>
                    <asp:DropDownList ID="professorDropdown" runat="server" CssClass="form-control">
                    </asp:DropDownList>
                </div>
            </div>
            <div class="col">
                <div class="form-group">
                    <label for="turmaDropdown">Turma:</label>
                    <asp:DropDownList ID="turmaDropdown" runat="server" CssClass="form-control" onchange="updateModulos()">
                    </asp:DropDownList>
                </div>
            </div>
            <div class="col">
                <div class="form-group">
                    <label for="salaDropdown">Sala:</label>
                    <asp:DropDownList ID="salaDropdown" runat="server" CssClass="form-control">
                    </asp:DropDownList>
                </div>
            </div>

            <div class="col">
                <div class="form-group">
                    <label for="moduloDropdown">Modulo:</label>
                    <asp:DropDownList ID="moduloDropdown" runat="server" CssClass="form-control">
                    </asp:DropDownList>
                </div>
            </div>
        </div>
        <div>
            <div id='calendar' style="width: 100%; height: 100%; margin-top: 20px; margin-bottom: 20px"></div>

        </div>
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
                    <input type="hidden" id="selectedDate" />

                    <div class="row" style="padding: 0px 20px; gap: 1rem;">
                        <div class="form-group">
                            <label for="startTime">Hora de início:</label>
                            <input type="time" class="form-control" id="startTime">
                        </div>
                        <div class="form-group">
                            <label for="endTime">Hora de término:</label>
                            <input type="time" class="form-control" id="endTime">
                        </div>
                    </div>
                    <h5>Horários Indisponíveis:</h5>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Hora de Início</th>
                                <th>Hora de Término</th>
                            </tr>
                        </thead>
                        <tbody id="indisponivelList">
                        </tbody>
                    </table>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn btn-primary" onclick="confirmarMarcacao()">Confirmar</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>


