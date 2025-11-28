package com.timemanagement;

import java.util.ArrayList;
import java.util.List;

public class GoalManager {
    private List<Goal> goals;
    private List<Task> tasks;

    public GoalManager() {
        goals = new ArrayList<>();
        tasks = new ArrayList<>();
    }

    public void addGoal(Goal goal) {
        goals.add(goal);
    }

    public void addTask(Task task) {
        tasks.add(task);
    }

    public List<Goal> getGoals() {
        return goals;
    }

    public List<Task> getTasks() {
        return tasks;
    }

    public void completeGoal(int index) {
        if (index >= 0 && index < goals.size()) {
            goals.get(index).complete();
        } else {
            System.out.println("Invalid goal index.");
        }
    }

    public void printGoals() {
        System.out.println("Goals:");
        for (int i = 0; i < goals.size(); i++) {
            System.out.println((i + 1) + ". " + goals.get(i));
        }
    }

    public void printTasks() {
        System.out.println("Tasks:");
        for (Task task : tasks) {
            System.out.println(task);
        }
    }
}
