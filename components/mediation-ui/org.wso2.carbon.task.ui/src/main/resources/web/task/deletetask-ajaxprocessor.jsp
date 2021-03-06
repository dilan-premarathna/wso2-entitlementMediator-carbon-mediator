<!--
~ Copyright (c) 2005-2010, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
~
~ WSO2 Inc. licenses this file to you under the Apache License,
~ Version 2.0 (the "License"); you may not use this file except
~ in compliance with the License.
~ You may obtain a copy of the License at
~
~ http://www.apache.org/licenses/LICENSE-2.0
~
~ Unless required by applicable law or agreed to in writing,
~ software distributed under the License is distributed on an
~ "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
~ KIND, either express or implied. See the License for the
~ specific language governing permissions and limitations
~ under the License.
-->
<%@ page import="org.wso2.carbon.task.ui.internal.TaskClientConstants" %>
<%@ page import="org.wso2.carbon.task.ui.internal.TaskManagementClient" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:bundle basename="org.wso2.carbon.task.ui.i18n.Resources">

    <%
        //ignore methods other than post
        if (!request.getMethod().equalsIgnoreCase("POST")) {
            response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
            return;
        } else {
            TaskManagementClient client;
            try {

                String name = request.getParameter("taskName");
                if (name == null || "".equals(name)) {
                    throw new ServletException("Task name is empty");
                }

                String group = request.getParameter("taskGroup");
                if (group == null || "".equals(group)) {
                    throw new ServletException("Task group is empty");
                }

                client = TaskManagementClient.getInstance(config, session);
                name = name.trim();
                client.deleteTaskDescription(name, group);
//            request.getSession().removeAttribute(TaskClientConstants.TASK_KEY + name);
            } catch (Throwable e) {
                request.getSession().setAttribute(TaskClientConstants.EXCEPTION, e);
    %>
    <script type="text/javascript">
        jQuery(document).ready(function () {
            CARBON.showErrorDialog('<%=e.getMessage()%>');
        });
    </script>
    <%
                return;
            }
        }
    %>
</fmt:bundle>