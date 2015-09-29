<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="guestbook.Greeting"%>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.googlecode.objectify.*" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
  <head>    
    <link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
   
  	<h2> Welcome to Vannara and Akshar's Blog</h2>
  	 <img src="http://hdwgo.com/wp-content/uploads/2015/03/abstract-bottle-hd-wallpaper.jpg" height=200 weight=300>
  	 <br>
  	 <font size="2"><i>What's in your mind when you see this pic?</i></font>
  </head>

  <body>
<%
    String guestbookName = request.getParameter("guestbookName");

    if (guestbookName == null) 
    {
        guestbookName = "default";
    }

    pageContext.setAttribute("guestbookName", guestbookName);
    UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();

    if (user != null) {
    

    
    
    
    
    
      pageContext.setAttribute("user", user);
%>

<p>Hello, ${fn:escapeXml(user.nickname)}! (You can
<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign out</a>.)</p>

<%

    } 
    else 
    {

%>

<p>Hello!

<a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a>
to post a new comment.</p>

<%

    }

%>

 

<%


    ObjectifyService.register(guestbook.Greeting.class);
    List<Greeting> greetings=ObjectifyService.ofy().load().type(Greeting.class).list();
  	//  Collections.sort(greetings);
  	Collections.sort(greetings, Collections.reverseOrder());

    if (greetings.isEmpty())
    {

        %>
        <p>Guestbook '${fn:escapeXml(guestbookName)}' has no messages.</p>
        <%

    } 
    else
    {
        %>
        
        
        
        
        
        <%

//		greetings.clearA();
//      for (Greeting greeting : greetings) 

	for(int i=0; i<=greetings.size() && i<5;i++)
        {
        	Greeting greeting=greetings.get(i);
            pageContext.setAttribute("greeting_content", greeting.getContent());
            pageContext.setAttribute("greeting_title", greeting.getTitle());
            pageContext.setAttribute("greeting_date", greeting.getDate());
            if (greeting.getUser() == null)
            {
                %>
                <p>An anonymous person wrote on ${fn:escapeXml(greeting_date)}:</p>
                <%
            } 
            else 
            {
                pageContext.setAttribute("greeting_user", greeting.getUser());
                %>
                <p><b>${fn:escapeXml(greeting_user.nickname)}</b> wrote on ${fn:escapeXml(greeting_date)}:</p>
                <%
            }
         %>
          	<blockquote>  <i><u>${fn:escapeXml(greeting_title)}</u></i></blockquote>
            <blockquote>  ${fn:escapeXml(greeting_content)}</blockquote>

            <%
     	}
    }
    
			

	if(user!=null)
	{
	%>

	 <a href="newPost.jsp") %>New Post</a></p>
	 
	 
    <%
	}
	%>
   
    <a href="view_all.jsp") %>view all</a></p>

  </body>

</html>