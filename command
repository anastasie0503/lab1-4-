# command.py
from abc import ABC, abstractmethod

class Command(ABC):
    @abstractmethod
    def execute(self) -> None:
        pass

    @abstractmethod
    def undo(self) -> None:
        pass

class TextEditor:
    def __init__(self):
        self.text = ""

    def write(self, chars: str):
        self.text += chars

    def delete_last(self, n: int):
        self.text = self.text[:-n]

class WriteCommand(Command):
    def __init__(self, editor: TextEditor, chars: str):
        self.editor = editor
        self.chars = chars

    def execute(self) -> None:
        self.editor.write(self.chars)

    def undo(self) -> None:
        self.editor.delete_last(len(self.chars))

class CommandHistory:
    def __init__(self):
        self.history = []

    def push(self, command: Command):
        self.history.append(command)

    def pop(self) -> Command:
        return self.history.pop()

if __name__ == "__main__":
    editor = TextEditor()
    history = CommandHistory()

    cmd1 = WriteCommand(editor, "Hello ")
    cmd2 = WriteCommand(editor, "World!")

    cmd1.execute()
    cmd2.execute()
    print(editor.text)

    cmd2.undo()
    print(editor.text)

    cmd1.undo()
    print(editor.text)
