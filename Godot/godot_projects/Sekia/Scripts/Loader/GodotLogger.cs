using System;
using Godot;

namespace ET
{
    public class GodotLogger : ILog
    {
        public void Trace(string msg)
        {
            GD.Print(msg);
        }

        public void Debug(string msg)
        {
            GD.Print(msg);
        }

        public void Info(string msg)
        {
            GD.Print(msg);
        }

        public void Warning(string msg)
        {
            GD.PushWarning(msg);
        }

        public void Error(string msg)
        {
            GD.PushError(msg);
        }

        public void Error(Exception e)
        {
            GD.PushError(e.Message);
        }

        public void Trace(string message, params object[] args)
        {
            GD.Print(message, args);
        }

        public void Info(string message, params object[] args)
        {
            GD.Print(message, args);
        }

        public void Debug(string message, params object[] args)
        {
            GD.Print(message, args);
        }

        public void Warning(string message, params object[] args)
        {
            GD.PushWarning(message, args);
        }

        public void Error(string message, params object[] args)
        {
            GD.PushWarning(message, args);
        }
    }
}
