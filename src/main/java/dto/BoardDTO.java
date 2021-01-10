package dto;

public class BoardDTO {
	private int bno;
	private String title;
	private String bDate;
	private int bCount;
	private String writer;
	private String content;
	private int bLike;
	private int bHate;
	
	public BoardDTO(String title, String writer, String content) {
		super();
		this.title = title;
		this.writer = writer;
		this.content = content;
	}
	
	public BoardDTO(int bno, String title, String bDate, int bCount, String writer, String content, int bLike,
			int bHate) {
		super();
		this.bno = bno;
		this.title = title;
		this.bDate = bDate;
		this.bCount = bCount;
		this.writer = writer;
		this.content = content;
		this.bLike = bLike;
		this.bHate = bHate;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getbDate() {
		return bDate;
	}
	public void setbDate(String bDate) {
		this.bDate = bDate;
	}
	public int getbCount() {
		return bCount;
	}
	public void setbCount(int bCount) {
		this.bCount = bCount;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getbLike() {
		return bLike;
	}
	public void setbLike(int bLike) {
		this.bLike = bLike;
	}
	public int getbHate() {
		return bHate;
	}
	public void setbHate(int bHate) {
		this.bHate = bHate;
	}
	@Override
	public String toString() {
		return "BoardDTO [bno=" + bno + ", title=" + title + ", bDate=" + bDate + ", bCount=" + bCount + ", content="
				+ content + ", bLike=" + bLike + ", bHate=" + bHate + "]";
	}
	
	
	
}
