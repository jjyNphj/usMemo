package usMemo.common.logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.ibatis.common.logging.Log;
import com.ibatis.common.logging.LogFactory;

public class LoggerInterceptor extends HandlerInterceptorAdapter{
	protected Log log= LogFactory.getLog(LoggerInterceptor.class);
	
	/*
	 * 전처리기임. 
	 * 컨트롤러 호출되기 전에 실행됨.
	 */
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		if (log.isDebugEnabled()) {
            log.debug("======================================          START         ======================================");
            log.debug(" Request URI \t:  " + request.getRequestURI());
            //현재 호출된 URI가 뭔지 보여줌
        }
        return super.preHandle(request, response, handler);
	}
	
	/*
	 * 후처리기임.
	 * 컨트롤러 실행 후 호출됨
	 */
	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		if (log.isDebugEnabled()) {
            log.debug("======================================           END          ======================================\n");
        }
	}
	

}
