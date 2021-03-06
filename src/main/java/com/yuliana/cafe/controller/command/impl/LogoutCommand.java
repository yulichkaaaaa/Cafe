package com.yuliana.cafe.controller.command.impl;

import com.yuliana.cafe.controller.command.ActionCommand;
import com.yuliana.cafe.controller.command.PagePath;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LogoutCommand implements ActionCommand {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String page = PagePath.MENU_PAGE;
        request.getSession().invalidate();
        return page;
    }
}