package talkPick.global.security.exception;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;
import talkPick.global.common.constants.auth.AuthConstants;
import talkPick.global.error.ErrorCode;
import talkPick.global.error.ErrorResponse;

import java.io.IOException;
import java.io.PrintWriter;

@RequiredArgsConstructor
@Component
public class JwtAuthenticationEntryPoint implements AuthenticationEntryPoint {
    private final ObjectMapper objectMapper;

    @Override
    public void commence(HttpServletRequest request, HttpServletResponse response, AuthenticationException authException) throws IOException {
        handleException(response);
    }

    private void handleException(HttpServletResponse response) throws IOException {
        setResponse(response, HttpStatus.UNAUTHORIZED, ErrorCode.UNAUTHORIZED);
    }

    private void setResponse(HttpServletResponse response, HttpStatus httpStatus, ErrorCode failureCode) throws IOException {
        response.setContentType(MediaType.APPLICATION_JSON_VALUE);
        response.setCharacterEncoding(AuthConstants.CHARACTER_TYPE);
        response.setStatus(httpStatus.value());
        PrintWriter writer = response.getWriter();
        writer.write(objectMapper.writeValueAsString(ErrorResponse.of(failureCode)));
    }
}