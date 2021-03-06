package action;

import java.util.List;

import model.Question;
import service.AppService;

public class AllQuestionAction extends BaseAction {

	private static final long serialVersionUID = 1L;

	private AppService appService;

	public void setAppService(AppService appService) {
		this.appService = appService;
	}

	@Override
	public String execute() throws Exception {

		List<Question> questions = appService.getAllQuestion();
		request().setAttribute("questions", questions);

		return SUCCESS;
	}
}
