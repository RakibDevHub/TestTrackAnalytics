package com.bugcheck.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter("/*")
public class RedirectFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        String uri = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        String relativeUri = uri.substring(contextPath.length());

        switch (relativeUri) {
            case "/", "/index", "/index.jsp", "/home.jsp" ->
                httpResponse.sendRedirect(contextPath + "/home");
            case "/login.jsp", "/signin", "/signin.jsp" ->
                httpResponse.sendRedirect(contextPath + "/login");
            default ->
                chain.doFilter(request, response);
        }
    }
}
