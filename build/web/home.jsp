
<%@page import="entity.TipoTarefa"%>
<%@page import="java.util.*"%>
<%@page import="entity.Tarefa"%>
<%@page import="entity.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard de Tarefas</title>
        <link rel="stylesheet" href="css/homeStyle.css">
    </head>
    <body>
        
  <%
  
   
   
   Tarefa task = new  Tarefa();
   
   Usuario user = new Usuario();
   
  user.setEmail_usuario(user.getPegarEmail());
  user.setSenha_usuario(user.getPegarSenha());
  
   
  
  %>      
    
        <div class="container">
            <!-- Barra Lateral -->
            <aside class="sidebar" id="sidebar">
                <div class="logo" id="sidebar-logo">
                    <img src="Image/logo.png" alt="Logo Ocelot" id="sidebar-logo-img">
                    <button class="toggle-button" id="toggleButton">   
                        ☰
                    </button>


                </div>
                <nav>
                    <ul>
                       
                        <li><a href="home.jsp"><img src="logos/iconizer-home.svg" class="icon-image" alt="Home Icon"> <span class="sidebar-text">Tela Principal</span></a></li>  
                        
                        <%
                        if (user != null) {
                        user = user.verificarUsuario();
                        if (user.verificarUsuario().getNivel_permissao().equals("admin")){     
                        %><li><a href="users.jsp"><img src="logos/iconizer-users.svg" class="icon-image" alt="User Icon"> <span class="sidebar-text">Usuários</span></a></li>                      
                       <% } %>
                       
                        <%if (user.verificarUsuario().getNivel_permissao().equals("admin") || user.verificarUsuario().getNivel_permissao().equals("gerente")) {%>
                        <li><a href="relatorios.jsp"><img src="logos/iconizer-painel.svg" class="icon-image" alt="Report Icon"> <span class="sidebar-text">Relatórios</span></a></li>
                        <% }
                         }%>
                        <li><a href="index.html"><img src="logos/iconizer-sair.svg" class="icon-image" alt="Logout Icon"> <span class="sidebar-text">Logout</span></a></li>
                  
                    </ul>
                </nav>
            </aside>

            <!-- Conteúdo Principal -->
            <main class="main-content">


                <section class="dashboard">
                    <div class="dashboard-header">
                        <h2>Dashboard de Tarefas</h2>
                    </div>

                    
                    <header class="header">
                        <input type="text" placeholder="Pesquisar tarefa" class="search-bar"> 
                         <%if (user.verificarUsuario().getNivel_permissao().equals("admin") || user.verificarUsuario().getNivel_permissao().equals("gerente")) {%>
                        <button class="add-task-button" id="add-task-button-task">Adicionar Tarefa  +</button>
                        <button class="add-task-button" id="add-type-task-button-task">Adicionar tipo  +</button>
                         <% } %>
                        
                         <dialog class="Janela-modal-Tarefas">
                             <form action="IncluirTarefas.jsp">
                                
                                 <label for="nm" class="AbrirModalEscolha">Tipo da tarefa</label>
                                
                                 <div class="ModalEscolha">
                                    <%
                                    TipoTarefa tt = new TipoTarefa();
                                    List<TipoTarefa> listTipo = tt.adicionarTipo();
                                    
                                    for (TipoTarefa t : listTipo) {
                                    %>
                                   
                                    <input type="radio" name="id_tipo_tarefa" value="<%= t.getId_tipo_tarefa() %>">
                                    <label><%= t.getTipo_tarefa()%></label>
                                    
                                    <%}%>
                                </div>
                                <%  List<Usuario> listaUsu = new ArrayList<>();
                                   listaUsu = user.listarUsuario(); 
                                
                                for ( Usuario ss : listaUsu ) {
                                %>
                                
                                 <label><%= ss.getNome_usuario() %></label>
                                <input type="radio" name="id_usuario" value="<%= ss.getId_usuario() %>">
                                   
                                <%}%>
                                
                                <label for="password">Descrição da tarefa</label>
                                <input type="text" class="password" name="desc" placeholder="">
                                
                                <label for="atv">Data de inicio</label>
                                <input type="Date" class="atv" name="dataIncio" placeholder="" maxlength="8">
                                
                                <label for="atv">Data de termino</label>
                                <input type="Date" class="np" name="DataTermino" placeholder=""  maxlength="8">
                               

                                <input type="submit" value="Adicionar" class="submit">
                            </form>
                            
                        </dialog>
                        
                         <dialog class="Janela-modal-Tipo-Tarefas">
                             <form action="incluirTipotarefa.jsp">
                                
                                <label for="nm"> tipo da tarefa</label>
                                <input type="text" class="nm" name="tipo_tarefa" placeholder="" minlength="4">
                                <input type="submit" value="Adicionar" class="submit">
                            </form>
                            
                        </dialog>
                       
                    </header>
                    <!-- Botões de Filtro -->
                    <div class="task-filters">
                        <button class="filter-button">Pendente</button>
                        <button class="filter-button">Em andamento</button>
                        <button class="filter-button">Concluída</button>
                    </div>
                    
                   

                    <!-- Lista de Tarefas (Atrasadas, Em andamento, Concluídas) -->
                    <div class="task-grid" style="display: flex; flex-direction: column">
                        <!-- Exemplo de card de tarefa -->
                        <%
                            List<Tarefa> lista = new ArrayList<>();
                             lista = task.listarTarefas();
                             
                              for (Tarefa de : lista){
                        %>
                        <div class="task-card">
                            <div class="task-header">
                                <span class="task-title"><%= de.getTipo_tarefa()%></span>
                                <div class="task-actions">
                                    <button class="edit-button">✏️</button>
                                    <button class="delete-button">🗑️</button>
                                </div>
                            </div>
                            <p class="task-description"><%= de.getDesc_tarefa() %></p>     
                            <p class="task-description"><%= de.getStatus()%></p>
                            <span class="task-date"><%= de.getData_inicio_tarefa()%></span><br>
                            <span class="task-date"><%= de.getData_fim_tarefa()%></span><br>
                            <span class="task-owner"><%= de.getNome_usuario()%></span>
                        </div>
                                <%}%>
                        
                        </div>
                    </div>
                </section>
            </main>
        </div>
        
        

        <script>
            
const buttonTask = document.querySelector("#add-task-button-task");
const modalTask = document.querySelector(".Janela-modal-Tarefas");

buttonTask.onclick = function(){

    modalTask.showModal();

};  

const buttontype = document.querySelector("#add-type-task-button-task");
const modaltype = document.querySelector(".Janela-modal-Tipo-Tarefas");


buttontype.onclick = function (){
    modaltype.showModal();
};


const buttonEscolher = document.querySelector(".AbrirModalEscolha");
const ModalEscolher = document.querySelector(".ModalEscolha");

buttonEscolher.onclick = function (){
    ModalEscolher.style.display = "block";
};




            
            
        </script>
       
    </body>
</html>
