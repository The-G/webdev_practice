package memo.model;

public class MemoVO {
	private int no;
	private String name;
	private String title;
	private String content;
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	@Override
	public String toString() {
		return "MemoVO [no=" + no + ", name=" + name + ", title=" + title + ", content=" + content + "]";
	}
	
	
}
