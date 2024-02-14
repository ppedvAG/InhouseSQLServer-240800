

/****** Object:  StoredProcedure [dbo].[PrepareWorkbench]    Script Date: 14.02.2024 13:28:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[PrepareWorkbench]
	@create_table	BIT = 1,
	@fill_table		BIT = 1,
	@language_id	INT	= 0
AS
	SET NOCOUNT ON;
	IF OBJECT_ID(N'dbo.messages', N'U') IS NOT NULL
	BEGIN
		RAISERROR (N'dropping existing table...', 0, 1) WITH NOWAIT;
		DROP TABLE dbo.messages;
	END
	IF @create_table = 0
		RETURN;
	IF @create_table = 1
	BEGIN
		RAISERROR (N'creating demo table [dbo].[messages]...', 0, 1) WITH NOWAIT;
		CREATE TABLE dbo.messages
		(
			message_id		INT,
			language_id		INT,
			severity		TINYINT,
			is_event_logged	BIT,
			[text]			CHAR(2048)
		);
	END
	IF @fill_table = 1
	BEGIN
		RAISERROR (N'filling demo table with data...', 0, 1) WITH NOWAIT;
		INSERT INTO dbo.messages WITH (TABLOCK)
		(message_id, language_id, severity, is_event_logged, [text])
		SELECT	message_id,
				language_id,
				severity,
				is_event_logged,
				[text]
		FROM	sys.messages
		WHERE	language_id = @language_id
				OR (@language_id = 0);
	END
	SET NOCOUNT OFF;
GO

