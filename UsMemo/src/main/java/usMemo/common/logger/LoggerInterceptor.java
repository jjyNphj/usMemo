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
	 * ��ó������. 
	 * ��Ʈ�ѷ� ȣ��Ǳ� ���� �����.
	 */
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		if (log.isDebugEnabled()) {
            log.debug("======================================          START         ======================================");
            log.debug(" Request URI \t:  " + request.getRequestURI());
            //���� ȣ��� URI�� ���� ������
        }
        return super.preHandle(request, response, handler);
	}
	
	/*
	 * ��ó������.
	 * ��Ʈ�ѷ� ���� �� ȣ���
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
